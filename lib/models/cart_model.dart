import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/interfaces/cart_interface.dart';
import 'package:flutter_app_marketplace/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  User user;
  List<Cart> products = [];
  bool isLoading = false;
  String coupon;
  int discount = 0;

  CartModel(this.user) {
    if(user.isLogged()) {
      _loadCartItems();
    }
  }

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  void addCartItem(Cart cart) {
    products.add(cart);
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").add(cart.toMap()).then((value) {
      cart.id = value.documentID;
    });
    notifyListeners();
  }

  void removeCartItem(Cart cart) {
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cart.id).delete();
    products.remove(cart);
    notifyListeners();
  }

  void addQuantity(Cart cart) {
    cart.quantity++;
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cart.id).updateData(cart.toMap());
    notifyListeners();
  }

  void removeQuantity(Cart cart) {
    cart.quantity--;
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cart.id).updateData(cart.toMap());
    notifyListeners();
  }

  void _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").getDocuments();
    products = query.documents.map((e) => Cart.fromDocument(e)).toList();
    notifyListeners();
  }

  void setCoupon(String coupon, int discount) {
    this.coupon = coupon;
    this.discount = discount;
  }

  double getProductsPrice() {
    double price = 0;
    for(Cart product in products) {
      if(product.productData != null) {
        price += product.quantity * product.productData.price;
      }
    }
    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discount / 100;
  }

  double getShipPrice() {
    return 6.19;
  }

  void updateCart() {
    notifyListeners();
  }

  Future<String> finishOrder() async {
    if(products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double price = getProductsPrice();
    double discount = getDiscount();
    double shipPrice = getShipPrice();

    DocumentReference order = await Firestore.instance.collection("orders").add({
      "user": user.firebaseUser.uid,
      "products": products.map((e) => e.toMap()).toList(),
      "price": price,
      "discount": discount,
      "shipPrice": shipPrice,
      "total": price - discount + shipPrice,
      "status": 1
    });

    await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("orders").document(order.documentID).setData({
      "id": order.documentID
    });
    
    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").getDocuments();
    for(DocumentSnapshot doc in query.documents) {
      doc.reference.delete();
    }

    products.clear();
    coupon = null;
    discount = 0;

    isLoading = false;
    notifyListeners();

    return order.documentID;
  }
}
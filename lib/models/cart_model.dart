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
}
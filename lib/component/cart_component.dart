import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/interfaces/cart_interface.dart';
import 'package:flutter_app_marketplace/interfaces/product_interface.dart';

class CartComponent extends StatelessWidget {

  final Cart cart;

  CartComponent(this.cart);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cart.productData == null ?
      FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection("products").document(cart.category).collection("itens").document(cart.product).get(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            cart.productData = Product.fromDocument(snapshot.data);
            return _buildContent();
          } else {
            return Container(
              height: 70,
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            );
          }
        }
      ) : _buildContent(),
    );
  }

  Widget _buildContent() {
    return Container();
  }
}

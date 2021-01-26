import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My cart"),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int totalProducts = model.products.length;
                return Text("${totalProducts ?? 0} ${totalProducts == 1 ? "ITEM" : "ITEMS"}",
                  style: TextStyle(
                    fontSize: 17
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

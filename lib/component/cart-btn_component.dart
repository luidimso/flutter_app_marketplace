import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/pages/cart_page.dart';

class CartBtnComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CartPage()
        ));
      },
      child: Icon(Icons.shopping_cart,
        color: Colors.white,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

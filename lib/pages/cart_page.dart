import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/component/cart_component.dart';
import 'package:flutter_app_marketplace/component/discount-card_component.dart';
import 'package:flutter_app_marketplace/models/cart_model.dart';
import 'package:flutter_app_marketplace/models/user_model.dart';
import 'package:flutter_app_marketplace/pages/login_page.dart';
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
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if(model.isLoading && User.of(context).isLogged()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(!User.of(context).isLogged()) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.remove_shopping_cart,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text("Login to add products!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginPage()
                      ));
                    },
                    child: Text("Login",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            );
          } else if(model.products == null || model.products.length == 0) {
            return Center(
              child: Text("There is no product on the cart!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products.map((e) {
                    return CartComponent(e);
                  }).toList(),
                ),
                DiscountCardComponent()
              ],
            );
          }
        },
      )
    );
  }
}

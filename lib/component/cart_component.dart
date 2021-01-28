import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/interfaces/cart_interface.dart';
import 'package:flutter_app_marketplace/interfaces/product_interface.dart';
import 'package:flutter_app_marketplace/models/cart_model.dart';

class CartComponent extends StatelessWidget {

  final Cart cart;

  CartComponent(this.cart);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      return Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: 120,
            child: Image.network(cart.productData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(cart.productData.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17
                      ),
                    ),
                    Text("Size ${cart.size}",
                      style: TextStyle(
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    Text("R\$ ${cart.productData.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.remove),
                            color: Theme.of(context).primaryColor,
                            onPressed: cart.quantity > 1 ? () {
                              CartModel.of(context).removeQuantity(cart);
                            } : null
                        ),
                        Text(cart.quantity.toString()),
                        IconButton(
                            icon: Icon(Icons.add),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              CartModel.of(context).addQuantity(cart);
                            }
                        ),
                        FlatButton(
                          onPressed: () {
                            CartModel.of(context).removeCartItem(cart);
                          },
                          child: Text("Remove"),
                          textColor: Colors.grey[500],
                        )
                      ],
                    )
                  ],
                ),
              )
          )
        ],
      );
    }

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
}

import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPriceComponent extends StatelessWidget {

  final VoidCallback buy;

  CartPriceComponent(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: EdgeInsets.all(16),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            double price = model.getProductsPrice();
            double discount = model.getDiscount();
            double shipPrice = model.getShipPrice();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Order summary",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Subtotal"),
                    Text("R\$ ${price.toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Discount"),
                    Text("R\$ ${discount.toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Delivery"),
                    Text("R\$ ${shipPrice.toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total",
                      style: TextStyle(
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Text("R\$ ${(price + shipPrice - discount).toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                RaisedButton(
                  onPressed: buy,
                  child: Text("Finish order"),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

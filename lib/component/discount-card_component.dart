import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/models/cart_model.dart';

class DiscountCardComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text("Discount coupon",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700]
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type your coupon"
              ),
              initialValue: CartModel.of(context).coupon ?? "",
              onFieldSubmitted: (text) {
                Firestore.instance.collection("coupons").document(text).get().then((value) {
                  if(value.data != null) {
                    CartModel.of(context).setCoupon(text, value.data["discount"]);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("${value.data["discount"]}% discount applied!"),
                      backgroundColor: Theme.of(context).primaryColor,
                    ));
                  } else {
                    CartModel.of(context).setCoupon(null, 0);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Nonexistent coupon!"),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

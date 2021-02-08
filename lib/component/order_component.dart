import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderComponent extends StatelessWidget {

  final String id;

  OrderComponent(this.id);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance.collection("orders").document(id).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              int status = snapshot.data["status"];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Order code: ${snapshot.data.documentID}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(_buildProductsText(snapshot.data)),
                  SizedBox(
                    height: 4,
                  ),
                  Text("Order status: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCircle("1", "Preparation", 1, status),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey[500],
                      ),
                      _buildCircle("2", "Transport", 2, status),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey[500],
                      ),
                      _buildCircle("3", "Delivery", 3, status),
                    ],
                  )
                ],
              );
            }
          },
        ),
      )
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = "Description:\n";
    for(LinkedHashMap product in snapshot.data["products"]) {
      text += "${product["quantity"]} x ${product["resume"]["title"]} (R\$ ${product["resume"]["price"].toStringAsFixed(2)})\n";
    }
    return text += "Total R\$ ${snapshot.data["total"].toStringAsFixed(2)}";
  }

  Widget _buildCircle(String title, String subtitle, int status, int currentStatus) {
    Color backgroundColor;
    Widget child;

    if(status > currentStatus) {
      backgroundColor = Colors.grey[500];
      child = Text(title,
        style: TextStyle(
          color: Colors.white
        ),
      );
    } else if (status == currentStatus) {
      backgroundColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(title,
            style: TextStyle(
              color: Colors.white
            ),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backgroundColor = Colors.green;
      child = Icon(Icons.check,
        color: Colors.white,
      );
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: backgroundColor,
          child: child,
        ),
        Text(subtitle)
      ],
    );
  }
}

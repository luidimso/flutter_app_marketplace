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
                  Text(_buildProductsText(snapshot.data))
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
}

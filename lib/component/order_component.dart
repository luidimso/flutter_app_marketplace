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
                children: <Widget>[
                  Text("Order code: ${snapshot.data.documentID}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              );
            }
          },
        ),
      )
    );
  }
}

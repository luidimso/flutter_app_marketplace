import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/component/category_component.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var divider = ListTile.divideTiles(
            tiles: snapshot.data.documents.map((e) {
                    return CategoryComponent(e);
                  }
              ).toList(),
            color: Colors.grey[500]
          ).toList();

          return ListView(
            children: divider,
          );
        }
      },
      future: Firestore.instance.collection("products").getDocuments(),
    );
  }
}

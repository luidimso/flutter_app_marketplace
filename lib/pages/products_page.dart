import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/component/product_component.dart';
import 'package:flutter_app_marketplace/interfaces/product_interface.dart';

class ProductsPage extends StatelessWidget {

  final DocumentSnapshot snapshot;

  ProductsPage(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data["title"]),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection("products").document(snapshot.documentID).collection("itens").getDocuments(),
            builder: (context, snapshot) {
              if(!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      GridView.builder(
                        padding: EdgeInsets.all(4),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 2,
                          childAspectRatio: 0.65
                        ),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          Product product = Product.fromDocument(snapshot.data.documents[index]);
                          product.category = this.snapshot.documentID;

                          return ProductComponent("grid", product);
                        }
                      ),
                      ListView.builder(
                        padding: EdgeInsets.all(4),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          Product product = Product.fromDocument(snapshot.data.documents[index]);
                          product.category = this.snapshot.documentID;

                          return ProductComponent("list", product);
                        }
                      )
                    ]
                );
              }
            },
          ),
        )
    );
  }
}

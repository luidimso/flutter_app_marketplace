import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_marketplace/interfaces/product_interface.dart';

class Cart {
  String id;
  String category;
  String product;
  int quantity;
  String size;
  Product productData;

  Cart.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    category = document.data["category"];
    product = document.data["product"];
    quantity = document.data["quantity"];
    size = document.data["size"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "product": product,
      "quantity": quantity,
      "size": size,
      "resume": productData.toResumedMap()
    };
  }
}
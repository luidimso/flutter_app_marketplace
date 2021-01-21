import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/interfaces/product_interface.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  ProductPage(this.product);

  @override
  _ProductPageState createState() => _ProductPageState(product);
}

class _ProductPageState extends State<ProductPage> {
  final Product product;

  _ProductPageState(this.product);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';

class OrderComponent extends StatelessWidget {

  final String id;

  OrderComponent(this.id);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(id)
    );
  }
}

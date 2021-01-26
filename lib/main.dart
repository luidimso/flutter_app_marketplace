import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/models/cart_model.dart';
import 'package:flutter_app_marketplace/models/user_model.dart';
import 'package:flutter_app_marketplace/pages/home_page.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<User>(
        model: User(),
        child: ScopedModelDescendant<User>(
          builder: (context, child, model) {
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                title: 'Marketplace',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  primaryColor: Color.fromARGB(255, 4, 125, 141),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                debugShowCheckedModeBanner: false,
                home: HomePage(),
              ),
            );
          },
        )
    );
  }
}
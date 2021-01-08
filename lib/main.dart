import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/component/drawer_component.dart';
import 'package:flutter_app_marketplace/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marketplace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4, 125, 141),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: DrawerComponent(),
        body: HomePage()
      ),
    );
  }
}
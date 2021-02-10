import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/component/cart-btn_component.dart';
import 'package:flutter_app_marketplace/component/drawer_component.dart';
import 'package:flutter_app_marketplace/tabs/home_tab.dart';
import 'package:flutter_app_marketplace/tabs/orders_tab.dart';
import 'package:flutter_app_marketplace/tabs/places_tab.dart';
import 'package:flutter_app_marketplace/tabs/products_tab.dart';

class HomePage extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          drawer: DrawerComponent(_pageController),
          body: HomeTab(),
          floatingActionButton: CartBtnComponent(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Products"),
            centerTitle: true,
          ),
          drawer: DrawerComponent(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartBtnComponent()
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Marketplaces"),
            centerTitle: true,
          ),
          drawer: DrawerComponent(_pageController),
          body: PlacesTab(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("My orders"),
            centerTitle: true,
          ),
          drawer: DrawerComponent(_pageController),
          body: OrdersTab(),
        )
      ],
    );
  }
}

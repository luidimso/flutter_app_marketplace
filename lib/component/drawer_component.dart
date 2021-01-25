import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/component/tile_component.dart';
import 'package:flutter_app_marketplace/models/user_model.dart';
import 'package:flutter_app_marketplace/pages/login_page.dart';
import 'package:scoped_model/scoped_model.dart';

class DrawerComponent extends StatelessWidget {

  final PageController pageController;

  DrawerComponent(this.pageController);

  @override

  Widget _backgroundBuilder() => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 203, 236, 241),
            Colors.white
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
      ),
    ),
  );

  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          _backgroundBuilder(),
          ListView(
            padding: EdgeInsets.only(top: 16, left: 32),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8,
                      left: 0,
                      child: Text("Marketplace",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: ScopedModelDescendant<User>(
                        builder: (context, child, model) {
                          print(model.isLogged());
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Hi ${!model.isLogged() ? "" : model.user["name"]} ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              GestureDetector(
                                child: Text(!model.isLogged() ? "Sign in or Log in > " : "Logout",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                onTap: () {
                                  if(!model.isLogged()) {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => LoginPage()
                                    ));
                                  } else {
                                    model.signout();
                                  }
                                },
                              )
                            ],
                          );
                        },
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              TileComponent(Icons.home, "Home", pageController, 0),
              TileComponent(Icons.list, "Products", pageController, 1),
              TileComponent(Icons.location_on, "Market", pageController, 2),
              TileComponent(Icons.playlist_add_check, "My order", pageController, 3)
            ],
          )
        ],
      ),
    );
  }
}

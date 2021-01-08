import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/component/tile_component.dart';

class DrawerComponent extends StatelessWidget {
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Hi, ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          GestureDetector(
                            child: Text("Sign in or Log in > ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            onTap: () {},
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              TileComponent(Icons.home, "Home"),
              TileComponent(Icons.list, "Products"),
              TileComponent(Icons.location_on, "Market"),
              TileComponent(Icons.playlist_add_check, "My order")
            ],
          )
        ],
      ),
    );
  }
}

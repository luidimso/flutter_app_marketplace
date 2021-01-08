import 'package:flutter/material.dart';

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
                      left: 8,
                      child: Text("Marketplace",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

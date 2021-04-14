//  home.dart
//  Created by Abhi Jadhav on 2/19/2021.
//  Copyright © 2021 Abhi Jadhav, Nathan Parikh, Aayush Goradia. All rights reserved.
//  Company Domain: abhijadhav.me
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Colors
Color accentColor = HexColor("#FF3988FE");
Color primaryColor = HexColor("#FFC4C4C4");

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: accentColor, fontSize: 70),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: accentColor,
            size: 70,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        actions: [
          Icon(Icons.battery_charging_full_rounded,
              color: Colors.green, size: 70)
        ],
        toolbarHeight: 120,
        backgroundColor: primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Text("Welcome to our app!",
                style: TextStyle(color: accentColor, fontSize: 50)),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(color: accentColor))),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/therapy');
                        },
                        child: Column(
                          children: <Widget>[
                            Text('🔹', style: TextStyle(fontSize: 80)),
                            Text("Therapy",
                                style: TextStyle(
                                    color: accentColor, fontSize: 40)),
                            Text(
                              "Play one sound at a time and check for a response",
                              style:
                                  TextStyle(color: accentColor, fontSize: 25),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(color: accentColor))),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/assessment');
                        },
                        child: Column(
                          children: <Widget>[
                            Text('📝', style: TextStyle(fontSize: 80)),
                            Text("Assessment",
                                style: TextStyle(
                                    color: accentColor, fontSize: 40)),
                            Text(
                              "Customize a routine and let it play",
                              style:
                                  TextStyle(color: accentColor, fontSize: 25),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(color: accentColor))),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/mysounds');
                        },
                        child: Column(
                          children: <Widget>[
                            Text('🎙', style: TextStyle(fontSize: 80)),
                            Text("My Sounds",
                                style: TextStyle(
                                    color: accentColor, fontSize: 40)),
                            Text(
                              "Add and delete sounds from your library",
                              style:
                                  TextStyle(color: accentColor, fontSize: 25),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image(image: AssetImage('assets/app_icon/applogo.png')),
              decoration: BoxDecoration(color: primaryColor),
            ),
            ListTile(
              title: Text(
                'Home',
                style: TextStyle(color: accentColor, fontSize: 40),
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Therapy',
                style: TextStyle(color: accentColor, fontSize: 40),
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushNamed(context, '/therapy');
              },
            ),
            ListTile(
              title: Text(
                'Assessment',
                style: TextStyle(color: accentColor, fontSize: 40),
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushNamed(context, '/assessment');
              },
            ),
            ListTile(
              title: Text(
                'My Sounds',
                style: TextStyle(color: accentColor, fontSize: 40),
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushNamed(context, '/mysounds');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

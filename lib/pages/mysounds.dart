import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

// Colors
Color accentColor = HexColor("#FF3988FE");
Color primaryColor = HexColor("#FFC4C4C4");

class MySounds extends StatefulWidget {
  @override
  _MySoundsState createState() => _MySoundsState();
}

class _MySoundsState extends State<MySounds> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'My Sounds',
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
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: ElevatedButton(
                      child: Text('Back'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(accentColor)),
                    )),
                Spacer()
              ],
            )
          ]),
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
                Navigator.pushReplacementNamed(context, '/home');
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
                Navigator.pushReplacementNamed(context, '/therapy');
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
                Navigator.pushReplacementNamed(context, '/assessment');
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
                Navigator.pop(context);
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

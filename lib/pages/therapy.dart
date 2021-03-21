//  therapy.dart
//  Created by Abhi Jadhav on 2/19/2021.
//  Copyright © 2021 Abhi Jadhav, Nathan Parikh, Aayush Goradia. All rights reserved.
//  Company Domain: abhijadhav.me
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Colors
Color accentColor = HexColor("#FF3988FE");
Color primaryColor = HexColor("#FFC4C4C4");
double _volume = 50.0;
int _direction = 1;
List<String> _locations = ['Clap', 'Song', 'Bark', 'Bell']; // Option 2
String _selectedLocation; // Option 2

class Therapy extends StatefulWidget {
  @override
  _TherapyState createState() => _TherapyState();
}

class _TherapyState extends State<Therapy> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Therapy',
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text('(1)',
                            style:
                                TextStyle(fontSize: 40, color: accentColor))),
                    Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text('(2)',
                            style:
                                TextStyle(fontSize: 40, color: accentColor))),
                    Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text('(3)',
                            style: TextStyle(fontSize: 40, color: accentColor)))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text('Sound:',
                            style:
                                TextStyle(fontSize: 40, color: accentColor))),
                    Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text('Side:',
                            style:
                                TextStyle(fontSize: 40, color: accentColor))),
                    Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text('Volume:',
                            style: TextStyle(fontSize: 40, color: accentColor)))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: DropdownButton(
                        hint: Text(
                            'Please choose a sound'), // Not necessary for Option 1
                        value: _selectedLocation,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                          });
                        },
                        items: _locations.map((location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: CupertinoSlidingSegmentedControl(
                            children: {
                              0: Text('Left'),
                              1: Text('Both'),
                              2: Text('Right'),
                            },
                            groupValue: _direction,
                            onValueChanged: (newValue) {
                              setState(() {
                                _direction = newValue;
                              });
                            })),
                    Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: CupertinoSlider(
                            value: _volume,
                            min: 0.0,
                            max: 100.0,
                            onChanged: (double value) {
                              setState(() => _volume = value);
                            }))
                  ],
                )
              ],
            ),
            IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 125,
                color: HexColor("#FF26710B"),
                onPressed: () {})
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
              child: Text('App Logo Here'),
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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

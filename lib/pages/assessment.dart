import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

// Colors
Color accentColor = HexColor("#FF3988FE");
Color primaryColor = HexColor("#FFC4C4C4");

// Global Vars:
Map<String, String> filenames = {
  'Bark': 'sounds/bark',
  'Bell': 'sounds/bell',
  'Bird Chirping': 'sounds/bird_chirping',
  'Clap': 'sounds/clap',
  'Gong': 'sounds/gong',
  'Ocean': 'sounds/ocean',
  'Song': 'sounds/song',
  'Whistle': 'sounds/whistle'
};

Map<String, String> emojis = {
  'Bark': '🐕',
  'Bell': '🔔',
  'Bird Chirping': '🐦',
  'Clap': '👏',
  'Gong': '🥁',
  'Ocean': '🌊',
  'Song': '🎶',
  'Whistle': '🌬️'
};

String _selectedroutine = 'Routine 1';
List<String> _routines = ['Routine 1', 'Routine 2', 'Create New'];
Map<String, List<String>> _routineinfo = {
  'Routine 1': [
    'Clap',
    'L',
    '3',
    'Clap',
    'R',
    '3',
    'Clap',
    'L',
    '3',
    'Clap',
    'R',
    '0'
  ],
  'Routine 2': [
    'Clap',
    'L',
    '3',
    'Clap',
    'L',
    '5',
    'Clap',
    'B',
    '7',
    'Bell',
    'R',
    '3'
  ],
  'Routine 3': [
    'Clap',
    'L',
    '10',
    'Clap',
    'R',
    '10',
    'Clap',
    'B',
    '10',
    'Clap',
    'L',
    '10'
  ],
  'Create New': [
    'Clap',
    'L',
    '3',
    'Clap',
    'R',
    '5',
    'Clap',
    'B',
    '7',
    'Bell',
    'R',
    '3'
  ]
};

class Assessment extends StatefulWidget {
  @override
  _AssessmentState createState() => _AssessmentState();
}

class _AssessmentState extends State<Assessment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Assessment',
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
            ),
            Container(
                alignment: Alignment.topCenter,
                child: Text('Choose the routine you would like:',
                    style: TextStyle(fontSize: 50, color: accentColor))),
            DropdownButton(
              hint:
                  Text('Please choose a routine'), // Not necessary for Option 1
              value: _selectedroutine,
              onChanged: (newValue) {
                setState(() {
                  _selectedroutine = newValue;
                });
              },

              items: _routines.map((routine) {
                return DropdownMenuItem(
                  child: new Text(routine),
                  value: routine,
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 175,
                  height: 175,
                  decoration: BoxDecoration(
                      border: Border.all(color: accentColor, width: 5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(emojis[_routineinfo[_selectedroutine][0]],
                          style: TextStyle(fontSize: 40)),
                      Text(_routineinfo[_selectedroutine][0],
                          style: TextStyle(fontSize: 40, color: accentColor)),
                      Text(_routineinfo[_selectedroutine][1],
                          style: TextStyle(fontSize: 40, color: accentColor)),
                    ],
                  ),
                ),
                Container(
                    width: 75,
                    height: 75,
                    decoration:
                        BoxDecoration(border: Border.all(color: accentColor)),
                    child: Center(
                      child: Text(_routineinfo[_selectedroutine][2],
                          style: TextStyle(fontSize: 40, color: accentColor)),
                    )),
                Container(
                  width: 175,
                  height: 175,
                  decoration: BoxDecoration(
                      border: Border.all(color: accentColor, width: 5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(emojis[_routineinfo[_selectedroutine][3]],
                          style: TextStyle(fontSize: 40)),
                      Text(_routineinfo[_selectedroutine][3],
                          style: TextStyle(fontSize: 40, color: accentColor)),
                      Text(_routineinfo[_selectedroutine][4],
                          style: TextStyle(fontSize: 40, color: accentColor)),
                    ],
                  ),
                ),
                Container(
                    width: 75,
                    height: 75,
                    decoration:
                        BoxDecoration(border: Border.all(color: accentColor)),
                    child: Center(
                      child: Text(_routineinfo[_selectedroutine][5],
                          style: TextStyle(fontSize: 40, color: accentColor)),
                    )),
                Container(
                  width: 175,
                  height: 175,
                  decoration: BoxDecoration(
                      border: Border.all(color: accentColor, width: 5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(emojis[_routineinfo[_selectedroutine][6]],
                          style: TextStyle(fontSize: 40)),
                      Text(_routineinfo[_selectedroutine][6],
                          style: TextStyle(fontSize: 40, color: accentColor)),
                      Text(_routineinfo[_selectedroutine][7],
                          style: TextStyle(fontSize: 40, color: accentColor)),
                    ],
                  ),
                ),
                Container(
                    width: 75,
                    height: 75,
                    decoration:
                        BoxDecoration(border: Border.all(color: accentColor)),
                    child: Center(
                      child: Text(_routineinfo[_selectedroutine][8],
                          style: TextStyle(fontSize: 40, color: accentColor)),
                    )),
                Container(
                  width: 175,
                  height: 175,
                  decoration: BoxDecoration(
                      border: Border.all(color: accentColor, width: 5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(emojis[_routineinfo[_selectedroutine][9]],
                          style: TextStyle(fontSize: 40)),
                      Text(_routineinfo[_selectedroutine][9],
                          style: TextStyle(fontSize: 40, color: accentColor)),
                      Text(_routineinfo[_selectedroutine][10],
                          style: TextStyle(fontSize: 40, color: accentColor)),
                    ],
                  ),
                )
              ],
            ),
            IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 125,
                color: HexColor("#FF26710B"),
                onPressed: () {
                  playAssessment();
                })
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
                Navigator.pushReplacementNamed(context, '/mysounds');
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> playAssessment() async {
  AudioPlayer advancedPlayer = AudioPlayer();
  AudioCache player = AudioCache(fixedPlayer: advancedPlayer);
  advancedPlayer.setVolume(0.5);
  String fn;
  int sleep_time;
  List<String> curr_playing = _routineinfo[_selectedroutine];
  for (int i = 0; i < curr_playing.length; i += 3) {
    if (curr_playing[i + 1] == 'L') {
      fn = filenames[curr_playing[i]] + 'l.mp3';
      await player.play(fn);
    } else if (curr_playing[i + 1] == 'R') {
      fn = filenames[curr_playing[i]] + 'r.mp3';
      await player.play(fn);
    } else {
      fn = filenames[curr_playing[i]] + '.mp3';
      await player.play(fn);
    }
    sleep_time = 3 + int.parse(curr_playing[i + 2]);
    sleep(Duration(seconds: sleep_time));
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

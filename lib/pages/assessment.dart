import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

// Colors
Color accentColor = HexColor("#FF3988FE");
Color primaryColor = HexColor("#FFC4C4C4");

AudioPlayer player = AudioPlayer();
AudioCache cache = AudioCache(fixedPlayer: player);
int StopPressed = 0;

List<String> _sounds = [
  'Bark',
  'Bell',
  'Bird Chirping',
  'Clap',
  'Gong',
  'Ocean',
  'Song',
  'Whistle'
];

List<String> _sides = ['L', 'R', 'B'];

List<String> _timedelays = ['1', '3', '5', '10', '15', '20', '25'];

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
List<String> _routines = ['Routine 1', 'Routine 2', 'Routine 3', 'Custom'];
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
    '5',
    'Clap',
    'L',
    '5',
    'Clap',
    'B',
    '5',
    'Bell',
    'R',
    '5'
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
  'Custom': [
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
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
          Widget>[
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
          hint: Text('Please choose a routine'), // Not necessary for Option 1
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
                  if (_selectedroutine == 'Custom')
                    DropdownButton(
                      hint: Text(
                          'Please choose a sound'), // Not necessary for Option 1
                      value: _routineinfo[_selectedroutine][0],
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _routineinfo[_selectedroutine][0] = newValue;
                        });
                      },
                      items: _sounds.map((sound) {
                        return DropdownMenuItem(
                          child: Center(
                              child: Text(sound, textAlign: TextAlign.center)),
                          value: sound,
                        );
                      }).toList(),
                    )
                  else
                    Text(_routineinfo[_selectedroutine][0],
                        style: TextStyle(fontSize: 40, color: accentColor)),
                  if (_selectedroutine == 'Custom')
                    DropdownButton(
                      hint: Text(
                          'Please choose a side'), // Not necessary for Option 1
                      value: _routineinfo[_selectedroutine][1],
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _routineinfo[_selectedroutine][1] = newValue;
                        });
                      },
                      items: _sides.map((side) {
                        return DropdownMenuItem(
                          child: Center(
                              child: Text(side, textAlign: TextAlign.center)),
                          value: side,
                        );
                      }).toList(),
                    )
                  else
                    Text(_routineinfo[_selectedroutine][1],
                        style: TextStyle(fontSize: 40, color: accentColor)),
                ],
              ),
            ),
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(border: Border.all(color: accentColor)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_selectedroutine == 'Custom')
                    DropdownButton(
                      hint: Text(
                          'Please choose a sound'), // Not necessary for Option 1
                      value: _routineinfo[_selectedroutine][2],
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _routineinfo[_selectedroutine][2] = newValue;
                          _routineinfo[_selectedroutine][5] = newValue;
                          _routineinfo[_selectedroutine][8] = newValue;
                        });
                      },
                      items: _timedelays.map((delay) {
                        return DropdownMenuItem(
                          child: Center(
                              child: Text(delay, textAlign: TextAlign.center)),
                          value: delay,
                        );
                      }).toList(),
                    )
                  else
                    Text(_routineinfo[_selectedroutine][2],
                        style: TextStyle(fontSize: 40, color: accentColor)),
                ],
              ),
            ),
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
                  if (_selectedroutine == 'Custom')
                    DropdownButton(
                      hint: Text(
                          'Please choose a sound'), // Not necessary for Option 1
                      value: _routineinfo[_selectedroutine][3],
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _routineinfo[_selectedroutine][3] = newValue;
                        });
                      },
                      items: _sounds.map((sound) {
                        return DropdownMenuItem(
                          child: Center(
                              child: Text(sound, textAlign: TextAlign.center)),
                          value: sound,
                        );
                      }).toList(),
                    )
                  else
                    Text(_routineinfo[_selectedroutine][3],
                        style: TextStyle(fontSize: 40, color: accentColor)),
                  if (_selectedroutine == 'Custom')
                    DropdownButton(
                      hint: Text(
                          'Please choose a side'), // Not necessary for Option 1
                      value: _routineinfo[_selectedroutine][4],
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _routineinfo[_selectedroutine][4] = newValue;
                        });
                      },
                      items: _sides.map((side) {
                        return DropdownMenuItem(
                          child: Center(
                              child: Text(side, textAlign: TextAlign.center)),
                          value: side,
                        );
                      }).toList(),
                    )
                  else
                    Text(_routineinfo[_selectedroutine][4],
                        style: TextStyle(fontSize: 40, color: accentColor)),
                ],
              ),
            ),
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(border: Border.all(color: accentColor)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_selectedroutine == 'Custom')
                    DropdownButton(
                      hint: Text(
                          'Please choose a sound'), // Not necessary for Option 1
                      value: _routineinfo[_selectedroutine][5],
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _routineinfo[_selectedroutine][2] = newValue;
                          _routineinfo[_selectedroutine][5] = newValue;
                          _routineinfo[_selectedroutine][8] = newValue;
                        });
                      },
                      items: _timedelays.map((delay) {
                        return DropdownMenuItem(
                          child: Center(
                              child: Text(delay, textAlign: TextAlign.center)),
                          value: delay,
                        );
                      }).toList(),
                    )
                  else
                    Text(_routineinfo[_selectedroutine][5],
                        style: TextStyle(fontSize: 40, color: accentColor)),
                ],
              ),
            ),
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
                  if (_selectedroutine == 'Custom')
                    DropdownButton(
                      hint: Text(
                          'Please choose a sound'), // Not necessary for Option 1
                      value: _routineinfo[_selectedroutine][6],
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _routineinfo[_selectedroutine][6] = newValue;
                        });
                      },
                      items: _sounds.map((sound) {
                        return DropdownMenuItem(
                          child: Center(
                              child: Text(sound, textAlign: TextAlign.center)),
                          value: sound,
                        );
                      }).toList(),
                    )
                  else
                    Text(_routineinfo[_selectedroutine][6],
                        style: TextStyle(fontSize: 40, color: accentColor)),
                  if (_selectedroutine == 'Custom')
                    DropdownButton(
                      hint: Text(
                          'Please choose a side'), // Not necessary for Option 1
                      value: _routineinfo[_selectedroutine][7],
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _routineinfo[_selectedroutine][7] = newValue;
                        });
                      },
                      items: _sides.map((side) {
                        return DropdownMenuItem(
                          child: Center(
                              child: Text(side, textAlign: TextAlign.center)),
                          value: side,
                        );
                      }).toList(),
                    )
                  else
                    Text(_routineinfo[_selectedroutine][7],
                        style: TextStyle(fontSize: 40, color: accentColor)),
                ],
              ),
            ),
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(border: Border.all(color: accentColor)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_selectedroutine == 'Custom')
                    DropdownButton(
                      hint: Text(
                          'Please choose a sound'), // Not necessary for Option 1
                      value: _routineinfo[_selectedroutine][8],
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _routineinfo[_selectedroutine][2] = newValue;
                          _routineinfo[_selectedroutine][5] = newValue;
                          _routineinfo[_selectedroutine][8] = newValue;
                        });
                      },
                      items: _timedelays.map((delay) {
                        return DropdownMenuItem(
                          child: Center(
                              child: Text(delay, textAlign: TextAlign.center)),
                          value: delay,
                        );
                      }).toList(),
                    )
                  else
                    Text(_routineinfo[_selectedroutine][8],
                        style: TextStyle(fontSize: 40, color: accentColor)),
                ],
              ),
            ),
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
                  if (_selectedroutine == 'Custom')
                    DropdownButton(
                      hint: Text(
                          'Please choose a sound'), // Not necessary for Option 1
                      value: _routineinfo[_selectedroutine][9],
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _routineinfo[_selectedroutine][9] = newValue;
                        });
                      },
                      items: _sounds.map((sound) {
                        return DropdownMenuItem(
                          child: Center(
                              child: Text(sound, textAlign: TextAlign.center)),
                          value: sound,
                        );
                      }).toList(),
                    )
                  else
                    Text(_routineinfo[_selectedroutine][9],
                        style: TextStyle(fontSize: 40, color: accentColor)),
                  if (_selectedroutine == 'Custom')
                    DropdownButton(
                      hint: Text(
                          'Please choose a side'), // Not necessary for Option 1
                      value: _routineinfo[_selectedroutine][10],
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _routineinfo[_selectedroutine][10] = newValue;
                        });
                      },
                      items: _sides.map((side) {
                        return DropdownMenuItem(
                          child: Center(
                              child: Text(side, textAlign: TextAlign.center)),
                          value: side,
                        );
                      }).toList(),
                    )
                  else
                    Text(_routineinfo[_selectedroutine][10],
                        style: TextStyle(fontSize: 40, color: accentColor)),
                ],
              ),
            )
          ],
        ),
        Row(children: [
          Spacer(),
          IconButton(
              icon: Icon(Icons.play_arrow),
              iconSize: 125,
              color: HexColor("#FF26710B"),
              onPressed: () {
                playAssessment();
              }),
          // IconButton(
          //     icon: Icon(Icons.pause),
          //     iconSize: 125,
          //     color: Colors.orange,
          //     onPressed: () {
          //       pauseAssessment(player);
          //     }),
          IconButton(
              icon: Icon(Icons.stop),
              iconSize: 125,
              color: Colors.red,
              onPressed: () {
                StopPressed = 1;
              }),
          Spacer()
        ], mainAxisAlignment: MainAxisAlignment.spaceEvenly)
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
  String fn;
  int sleep_time;
  List<String> curr_playing = _routineinfo[_selectedroutine];
  for (int i = 0; i < curr_playing.length; i += 3) {
    if (curr_playing[i + 1] == 'L') {
      fn = filenames[curr_playing[i]] + 'l.mp3';
      await cache.play(fn);
    } else if (curr_playing[i + 1] == 'R') {
      fn = filenames[curr_playing[i]] + 'r.mp3';
      await cache.play(fn);
    } else {
      fn = filenames[curr_playing[i]] + '.mp3';
      await cache.play(fn);
    }
    if (StopPressed == 1) {
      break;
    }
    sleep_time = 3 + int.parse(curr_playing[i + 2]);
    sleep(Duration(seconds: sleep_time));
  }
  StopPressed = 0;
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

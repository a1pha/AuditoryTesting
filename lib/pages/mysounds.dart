/*
 * Copyright 2018, 2019, 2020 Dooboolab.
 *
 * This file is part of Flutter-Sound.
 *
 * Flutter-Sound is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License version 3 (LGPL-V3), as published by
 * the Free Software Foundation.
 *
 * Flutter-Sound is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Flutter-Sound.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

Color accentColor = HexColor("#FF3988FE");
Color primaryColor = HexColor("#FFC4C4C4");

/*
 * This is an example showing how to record to a Dart Stream.
 * It writes all the recorded data from a Stream to a File, which is completely stupid:
 * if an App wants to record something to a File, it must not use Streams.
 *
 * The real interest of recording to a Stream is for example to feed a
 * Speech-to-Text engine, or for processing the Live data in Dart in real time.
 *
 */

///
typedef _Fn = void Function();

/// Example app.
class MySounds extends StatefulWidget {
  @override
  _MySoundsState createState() => _MySoundsState();
}

class _MySoundsState extends State<MySounds> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  // FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  final myController = TextEditingController();
  String _mPath = '.aac';

  @override
  void initState() {
    // _mPlayer!.openAudioSession().then((value) {
    _mPlayer.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // _mPlayer!.closeAudioSession();
    _mPlayer.closeAudioSession();
    _mPlayer = null;

    // _mRecorder!.closeAudioSession();
    _mRecorder.closeAudioSession();
    _mRecorder = null;

    myController.dispose();

    super.dispose();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    // await _mRecorder!.openAudioSession();
    await _mRecorder.openAudioSession();
    _mRecorderIsInited = true;
  }

  // ----------------------  Here is the code for recording and playback -------

  void record() {
    // _mRecorder!
    _mRecorder
        .startRecorder(
      toFile: _mPath,
      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
    )
        .then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    // await _mRecorder!.stopRecorder().then((value) {
    await _mRecorder.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        _mplaybackReady = true;
      });
    });
  }

  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        // _mRecorder!.isStopped &&
        _mRecorder.isStopped &&
        // _mPlayer!.isStopped);
        _mPlayer.isStopped);
    // _mPlayer!
    _mPlayer
        .startPlayer(
            fromURI: _mPath,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    _mPlayer.stopPlayer().then((value) {
      setState(() {});
    });
  }

// ----------------------------- UI --------------------------------------------

  _Fn getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer.isStopped) {
      return null;
    }
    return _mRecorder.isStopped ? record : stopRecorder;
  }

  _Fn getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder.isStopped) {
      return null;
    }
    return _mPlayer.isStopped ? play : stopPlayer;
  }

  @override
  Widget build(BuildContext context) {
    Widget makeBody() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name new sound',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.all(3),
              height: 80,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFFAF0E6),
                border: Border.all(
                  color: Colors.indigo,
                  width: 3,
                ),
              ),
              child: Row(children: [
                ElevatedButton(
                  onPressed: getRecorderFn(),
                  //color: Colors.white,
                  //disabledColor: Colors.grey,
                  child: Text(_mRecorder.isRecording ? 'Stop' : 'Record'),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(_mRecorder.isRecording
                    ? 'Recording in progress'
                    : 'Recorder is stopped'),
              ]),
            ),
            Container(
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.all(3),
              height: 80,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFFAF0E6),
                border: Border.all(
                  color: Colors.indigo,
                  width: 3,
                ),
              ),
              child: Row(children: [
                ElevatedButton(
                  onPressed: getPlaybackFn(),
                  //color: Colors.white,
                  //disabledColor: Colors.grey,
                  child: Text(_mPlayer.isPlaying ? 'Stop' : 'Play'),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(_mPlayer.isPlaying
                    ? 'Playback in progress'
                    : 'Player is stopped'),
              ]),
            ),
          ]);
    }

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
        body: makeBody(),
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
        ));
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

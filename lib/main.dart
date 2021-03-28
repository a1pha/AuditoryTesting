//  main.dart
//  Created by Abhi Jadhav on 2/19/2021.
//  Copyright © 2021 Abhi Jadhav, Nathan Parikh, Aayush Goradia. All rights reserved.
//  Company Domain: abhijadhav.me
import 'package:flutter/material.dart';
import 'package:auditory_testing/pages/home.dart';
import 'package:auditory_testing/pages/therapy.dart';
import 'package:auditory_testing/pages/assessment.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/therapy': (context) => Therapy(),
        '/assessment': (context) => Assessment()
      },
    );
  }
}

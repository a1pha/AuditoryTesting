//  main.dart
//  Created by Abhi Jadhav on 2/19/2021.
//  Copyright © 2021 Abhi Jadhav, Nathan Parikh, Aayush Goradia. All rights reserved.
//  Company Domain: abhijadhav.me
import 'package:flutter/material.dart';
import 'package:auditory_testing/pages/home.dart';
import 'package:auditory_testing/pages/therapy.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/therapy': (context) => Therapy()
      },
    ));

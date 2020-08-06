import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  primarySwatch: Colors.green,
  fontFamily: "Montserrat",
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  ),
);

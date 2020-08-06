import 'package:flutter/material.dart';
import 'package:sprout_app/blocs/overseer.dart';
import 'package:sprout_app/blocs/provider.dart';
import 'package:sprout_app/screens/main/main_screen.dart';
import 'package:sprout_app/themes.dart';

void main() {
  runApp(new SproutApp());
}

class SproutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      data: Overseer(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sprout App',
        theme: themeData,
        home: MainScreen(),
      ),
    );
  }
}

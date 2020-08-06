import 'package:flutter/material.dart';
import 'package:sprout_app/screens/main/components/buttons_container.dart';
import 'package:sprout_app/screens/main/components/form_container.dart';
import 'package:sprout_app/screens/main/components/main_title.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MainTitle(),
                FormContainer(),
                ButtonsContainer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

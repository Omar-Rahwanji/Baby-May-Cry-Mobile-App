

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 1),
      () async {
        final prefs = await SharedPreferences.getInstance();
        if (prefs.getBool("logged in") == true)
          Navigator.pushReplacementNamed(context, "/home", arguments: {
            'userName': prefs.getString("userName"),
            'userEmail': prefs.getString('userEmail'),
            'userPhoneNumber': prefs.getString("userPhoneNumber"),
          });
        else
          Navigator.pushReplacementNamed(context, "/login");
      },
    );
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            width: 300,
            child: Hero(
                tag: "logo",
                child: Image(image: AssetImage('assets/images/logo.png'))),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Future.delayed(
      const Duration(seconds: 1),
      () async {
        final prefs = await SharedPreferences.getInstance();
        if (prefs.getBool("isLoggedIn") == true) {
          HomePage.userRole = prefs.getString("role")!;
          Navigator.pushReplacementNamed(context, "/home", arguments: {
            'email': prefs.getString('email'),
            'fullName': prefs.getString('fullName')
          });
        } else if (prefs.getBool("isLoggedIn") == false) {
          Navigator.pushReplacementNamed(context, "/login");
        } else {
          Navigator.pushReplacementNamed(context, "/about-us");
        }
      },
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: screenWidth * 0.7,
              child: const Hero(
                tag: "logo",
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

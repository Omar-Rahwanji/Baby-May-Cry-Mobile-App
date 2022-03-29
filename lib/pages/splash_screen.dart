import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Future.delayed(
      const Duration(seconds: 1),
      () async {
        final prefs = await SharedPreferences.getInstance();
        if (prefs.getBool("isLoggedIn") == true) {
          Navigator.pushReplacementNamed(context, "/home", arguments: {
            'email': prefs.getString('email'),
            'fullName': prefs.getString('fullName')
          });
        } else {
          Navigator.pushReplacementNamed(context, "/login");
        }
      },
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationX(500),
            child: Container(
              margin: const EdgeInsets.only(bottom: 56),
              child: Image(
                image: const AssetImage("assets/images/border.png"),
                fit: BoxFit.fill,
                width: screenWidth,
                height: 157,
              ),
            ),
          ),
          SizedBox(height: 50),
          const Center(
            child: SizedBox(
              width: 300,
              child: Hero(
                  tag: "logo",
                  child: Image(image: AssetImage('assets/images/logo.png'))),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 134),
            child: Image(
              image: const AssetImage("assets/images/border.png"),
              fit: BoxFit.fill,
              width: screenWidth,
              height: 157,
            ),
          ),
        ],
      ),
    );
  }
}

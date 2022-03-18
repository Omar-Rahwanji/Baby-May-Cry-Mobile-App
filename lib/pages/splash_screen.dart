import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Hero(
              tag: "logo",
              child: Image(image: AssetImage('assets/images/logo.png'))),
        ),
      ),
    );
  }
}

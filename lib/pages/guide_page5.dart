import 'package:shared_preferences/shared_preferences.dart';

import '../static/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class GuidePage5 extends StatelessWidget {
  GuidePage5({Key? key}) : super(key: key);
  final List<TextAlign> textAlign = [TextAlign.left, TextAlign.right];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.12,
              width: screenWidth,
            ),
            SizedBox(
              width: screenWidth * 0.4,
              child: Hero(
                tag: "logo",
                child: Image(
                  image: const AssetImage("assets/images/logo.png"),
                  width: screenWidth * 0.8,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Hero(
              tag: "number",
              child: Image(
                image: const AssetImage("assets/images/numbers/5.png"),
                width: screenWidth * 0.2,
              ),
            ),
            SizedBox(height: screenHeight * 0.15),
            SizedBox(
              width: screenWidth * 0.76,
              child: Text(
                "You can see your baby cry reason in the middle".tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.12),
            MaterialButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                if (prefs.getBool("isLoggedIn") == true) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                } else {
                  prefs.setBool("isLoggedIn", false);
                  Navigator.pushNamed(context, "/login");
                }
              },
              child: Text(
                "DONE".tr(),
                style: const TextStyle(fontSize: 20),
              ),
              color: CustomColors.primary,
              textColor: Colors.white,
              minWidth: screenWidth * 0.5,
              padding: EdgeInsets.all(screenWidth * 0.03),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
            ),
          ],
        ),
      ),
    );
  }
}

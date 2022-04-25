import '../static/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class GuidePage3 extends StatelessWidget {
  GuidePage3({Key? key}) : super(key: key);
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
                image: const AssetImage("assets/images/numbers/3.png"),
                width: screenWidth * 0.2,
              ),
            ),
            SizedBox(height: screenHeight * 0.15),
            SizedBox(
              width: screenWidth * 0.76,
              child: Text(
                "Start recording your baby cry by pressing on the mic button"
                    .tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.12),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/guide4");
              },
              iconSize: 80,
              color: CustomColors.secondary,
              icon: Icon(
                translator.activeLanguageCode == "en"
                    ? Icons.arrow_circle_right
                    : Icons.arrow_circle_left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import '../static/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AboutUsPage extends StatelessWidget {
  AboutUsPage({Key? key}) : super(key: key);
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
            SizedBox(height: screenHeight * 0.1),
            SizedBox(
              width: screenWidth * 0.7,
              child: Text(
                "Understand your baby more".tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 34,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.054),
            SizedBox(
              width: screenWidth * 0.76,
              child: Text(
                "Understand the cry reason to act properly. We help by making you sure about your baby's daily needs."
                    .tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.044),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, "/guide1");
              },
              child: Text(
                "START".tr(),
                style: const TextStyle(fontSize: 20),
              ),
              color: CustomColors.primary,
              textColor: Colors.white,
              minWidth: screenWidth * 0.5,
              padding: EdgeInsets.all(screenWidth * 0.03),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
            ),
            SizedBox(height: screenHeight * 0.0475),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.302),
                  child: Image(
                    image: const AssetImage("assets/images/border.png"),
                    fit: BoxFit.fill,
                    width: screenWidth,
                    height: translator.activeLanguageCode == "en"
                        ? screenHeight * 0.2073
                        : screenHeight * 0.2009,
                  ),
                ),
                Hero(
                  tag: "logo",
                  child: Image(
                    image: const AssetImage("assets/images/logo.png"),
                    width: screenWidth * 0.8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

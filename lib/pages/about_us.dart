import '../static/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AboutUsPage extends StatelessWidget {
  AboutUsPage({Key? key}) : super(key: key);
  final List<TextAlign> textAlign = [TextAlign.left, TextAlign.right];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
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
            const SizedBox(height: 20),
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
            const SizedBox(height: 35),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "START".tr(),
                style: TextStyle(fontSize: 20),
              ),
              color: CustomColors.primary,
              textColor: Colors.white,
              minWidth: screenWidth * 0.5,
              padding: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
            ),
            SizedBox(height: translator.activeLanguageCode == "en" ? 42 : 37),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 236),
                  child: Image(
                    image: const AssetImage("assets/images/border.png"),
                    fit: BoxFit.fill,
                    width: screenWidth,
                    height: 157,
                  ),
                ),
                Container(
                  child: Hero(
                    tag: "logo",
                    child: Image(
                      image: AssetImage("assets/images/logo.png"),
                      width: screenWidth * 0.8,
                    ),
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

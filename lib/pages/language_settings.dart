import '../static/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({Key? key}) : super(key: key);

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  String currentLanguage =
      translator.activeLanguageCode == "en" ? "English" : "العربية";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.128),
            SizedBox(
              width: screenWidth * 0.7,
              child: Text(
                "Language settings".tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 34,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.128),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (translator.activeLanguageCode == "en")
                  Text("Choose the language".tr()),
                SizedBox(width: screenWidth * 0.05),
                DropdownButton(
                  isDense: true,
                  elevation: 16,
                  iconEnabledColor: CustomColors.primary,
                  value: currentLanguage,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: screenWidth * 0.07,
                  ),
                  items: ["English", "العربية"].map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      currentLanguage = newValue!;
                    });
                  },
                ),
                if (translator.activeLanguageCode == "ar")
                  const SizedBox(width: 10),
                if (translator.activeLanguageCode == "ar")
                  Text("Choose the language".tr()),
              ],
            ),
            SizedBox(height: screenHeight * 0.0635),
            MaterialButton(
              child: Text(
                "Change".tr(),
                style: TextStyle(fontSize: 20),
              ),
              color: CustomColors.primary,
              textColor: Colors.white,
              minWidth: screenWidth * 0.9,
              padding: EdgeInsets.all(screenWidth * 0.027),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              onPressed: () {
                translator.setNewLanguage(
                  context,
                  newLanguage: currentLanguage == "English" ? "en" : "ar",
                  remember: true,
                  restart: true,
                );
              },
            ),
            SizedBox(
              height: translator.activeLanguageCode == "ar"
                  ? screenHeight * 0.2066
                  : screenHeight * 0.1567,
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.128),
                  child: Image(
                    image: const AssetImage("assets/images/border.png"),
                    fit: BoxFit.fill,
                    width: screenWidth,
                    height: screenHeight * 0.2009,
                  ),
                ),
                Hero(
                  tag: "logo",
                  child: Image(
                    image: const AssetImage("assets/images/logo.png"),
                    width: screenWidth * 0.4,
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

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
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
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (translator.activeLanguageCode == "en")
                  Text("Choose the language".tr()),
                const SizedBox(width: 10),
                DropdownButton(
                  isDense: true,
                  elevation: 16,
                  iconEnabledColor: CustomColors.primary,
                  value: currentLanguage,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    size: 26,
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
            const SizedBox(height: 50),
            MaterialButton(
              child: Text(
                "Change".tr(),
                style: TextStyle(fontSize: 20),
              ),
              color: CustomColors.primary,
              textColor: Colors.white,
              minWidth: screenWidth * 0.9,
              padding: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              onPressed: () {
                translator.setNewLanguage(context,
                    newLanguage: currentLanguage == "English" ? "en" : "ar",
                    remember: true,
                    restart: true);
              },
            ),
            SizedBox(height: translator.activeLanguageCode == "ar" ? 161 : 122),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Image(
                    image: const AssetImage("assets/images/border.png"),
                    fit: BoxFit.fill,
                    width: screenWidth,
                    height: 157,
                  ),
                ),
                Container(
                  // margin: const EdgeInsets.only(bottom: 30),
                  child: Hero(
                    tag: "logo",
                    child: Image(
                      image: AssetImage("assets/images/logo.png"),
                      width: screenWidth * 0.4,
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

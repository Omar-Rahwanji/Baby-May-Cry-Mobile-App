

import 'package:baby_may_cry/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class LanguageSettings extends StatefulWidget {
  LanguageSettings({Key? key}) : super(key: key);

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  String currentLanguage =
      translator.activeLanguageCode == "en" ? "English" : "العربية";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Language settings".tr()),
        centerTitle: true,
        elevation: 16,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            margin: const EdgeInsets.only(bottom: 30, top: 30),
            child: const Hero(
              tag: "logo",
              child: Image(
                image: AssetImage("assets/images/logo.png"),
              ),
            ),
          ),
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
              if (translator.activeLanguageCode == "ar") const SizedBox(width: 10),
              if (translator.activeLanguageCode == "ar")
                Text("Choose the language".tr()),
            ],
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: screenWidth * 0.9,
            child: ElevatedButton(
              child: Text("Change".tr()),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () {
                translator.setNewLanguage(context,
                    newLanguage: currentLanguage == "English" ? "en" : "ar",
                    remember: true,
                    restart: true);
              },
            ),
          ),
        ],
      ),
    );
  }
}

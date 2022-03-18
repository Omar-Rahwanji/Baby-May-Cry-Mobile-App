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
      appBar: AppBar(
        title: Text("About us".tr()),
        centerTitle: true,
        elevation: 16,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  margin: const EdgeInsets.only(bottom: 20, top: 20),
                  child: const Hero(
                    tag: "logo",
                    child: Image(
                      image: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                ),
                Text(
                  "Arrow Business Services".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColors.secondary,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 15),
                Material(
                  borderRadius: BorderRadius.circular(20),
                  type: MaterialType.card,
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: screenWidth * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (translator.activeLanguageCode == "en")
                                const Icon(
                                  Icons.calendar_month,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "a private VIP service provider that was established back in 1999, being the second VIP service provider establishment in the Middle East."
                                      .tr(),
                                  textAlign: textAlign[
                                      (translator.activeLanguageCode == "en")
                                          ? 0
                                          : 1],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              if (translator.activeLanguageCode == "ar")
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.green,
                                  size: 30,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Material(
                  borderRadius: BorderRadius.circular(20),
                  type: MaterialType.card,
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: screenWidth * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (translator.activeLanguageCode == "en")
                                const Icon(
                                  Icons.location_pin,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "a professional service provider that ensures you cross the borders between Jordan and Palestine/Israel, easily, hassle-free, safe, and most of all in the least time possible."
                                      .tr(),
                                  textAlign: textAlign[
                                      (translator.activeLanguageCode == "en")
                                          ? 0
                                          : 1],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              if (translator.activeLanguageCode == "ar")
                                const Icon(
                                  Icons.location_pin,
                                  color: Colors.green,
                                  size: 30,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Material(
                  borderRadius: BorderRadius.circular(20),
                  type: MaterialType.card,
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: screenWidth * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (translator.activeLanguageCode == "en")
                                const Icon(
                                  Icons.people,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "employees are extremely professional ensuring your comfort, safety, and convenience as priority. Each passenger or family gets to travel in their own private car that is clean, spacious, and with well experienced drivers. From the moment you enter our lounge, until you cross the border everything is attended to through our services."
                                      .tr(),
                                  textAlign: textAlign[
                                      (translator.activeLanguageCode == "en")
                                          ? 0
                                          : 1],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              if (translator.activeLanguageCode == "ar")
                                const Icon(
                                  Icons.people,
                                  color: Colors.green,
                                  size: 30,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

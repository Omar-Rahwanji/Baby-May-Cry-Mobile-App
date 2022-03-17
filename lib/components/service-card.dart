import 'package:baby_may_cry/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ServiceCard extends StatelessWidget {
  ServiceCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.details})
      : super(key: key);
  final List<TextAlign> textAlign = [TextAlign.left, TextAlign.right];
  final String title;
  final String subtitle;
  final List<String> details;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        if (this.title != "")
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              this.title.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(color: CustomColors.secondary, fontSize: 25),
            ),
          ),
        SizedBox(height: 15),
        Material(
          borderRadius: BorderRadius.circular(20),
          type: MaterialType.card,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(15),
            width: screenWidth * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (this.subtitle != "")
                  Container(
                    width: screenWidth * 0.9,
                    child: Text(
                      this.subtitle.tr(),
                      textAlign: textAlign[
                          (translator.activeLanguageCode == "en") ? 0 : 1],
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(height: 20),
                for (int i = 0; i < details.length; i++)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (translator.activeLanguageCode == "en")
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 30,
                          ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            details[i].tr(),
                            textAlign: textAlign[
                                (translator.activeLanguageCode == "en")
                                    ? 0
                                    : 1],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        if (translator.activeLanguageCode == "ar")
                          Icon(
                            Icons.check_circle_outline,
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
        SizedBox(height: 10),
      ],
    );
  }
}

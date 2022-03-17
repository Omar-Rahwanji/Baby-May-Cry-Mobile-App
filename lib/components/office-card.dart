import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OfficeCard extends StatelessWidget {
  OfficeCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.phoneNumber,
    required this.fax,
  }) : super(key: key);
  final String? title;
  final String? subtitle;
  final String? phoneNumber;
  final String? fax;
  final List<TextAlign> textAlign = [TextAlign.left, TextAlign.right];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Material(
      type: MaterialType.card,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(20),
      elevation: 10,
      child: Container(
        // padding: EdgeInsets.all(10),
        height: 500,
        width: screenWidth * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/office.png"),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 250,
              width: screenWidth,
              child: Column(
                crossAxisAlignment: translator.activeLanguageCode == "en"
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (this.title!.tr() != '')
                    Text(
                      this.title!.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: textAlign[
                          (translator.activeLanguageCode == "en") ? 0 : 1],
                    ),
                  if (this.subtitle!.tr() != '')
                    Text(
                      this.subtitle!.tr(),
                      textAlign: textAlign[
                          (translator.activeLanguageCode == "en") ? 0 : 1],
                    ),
                  Text(
                    'Phone: '.tr() + this.phoneNumber!,
                    textAlign: textAlign[
                        (translator.activeLanguageCode == "en") ? 0 : 1],
                  ),
                  if (this.fax != '')
                    Text(
                      'Fax: '.tr() + this.fax!,
                      textAlign: textAlign[
                          (translator.activeLanguageCode == "en") ? 0 : 1],
                    ),
                  Text(
                    'Office hours:'.tr(),
                    textAlign: textAlign[
                        (translator.activeLanguageCode == "en") ? 0 : 1],
                  ),
                  Text(
                    '7am - 4pm Monday - Friday'.tr(),
                    textAlign: textAlign[
                        (translator.activeLanguageCode == "en") ? 0 : 1],
                  ),
                  Text(
                    '7am - 11am Saturday'.tr(),
                    textAlign: textAlign[
                        (translator.activeLanguageCode == "en") ? 0 : 1],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../static/colors.dart';

class CryingHistoryCard extends StatelessWidget {
  const CryingHistoryCard({
    Key? key,
    required this.reason,
    required this.duration,
    required this.date,
    required this.time,
    required this.timeStamp,
  }) : super(key: key);

  final String reason;
  final String duration;
  final DateTime date;
  final String time;
  final String timeStamp;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          SizedBox(height: 5),
          Card(
            color: Colors.white,
            borderOnForeground: true,
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.all(10),
                  isThreeLine: true,
                  leading: translator.activeLanguageCode == "en"
                      ? Icon(
                          Icons.water_drop_outlined,
                          size: 50,
                          color: CustomColors.primary,
                        )
                      : null,
                  trailing: translator.activeLanguageCode == "ar"
                      ? Icon(
                          Icons.water_drop_outlined,
                          size: 50,
                          color: CustomColors.primary,
                        )
                      : null,
                  title: Text(
                    "Crying date".tr() +
                        ": ${date.year}-${date.month}-${date.day} \n" +
                        "Crying time".tr() +
                        ": ${time} ${timeStamp}",
                    textDirection: translator.activeLanguageCode == "en"
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    style: TextStyle(color: CustomColors.secondary),
                  ),
                  subtitle: Text(
                    "Crying reason".tr() +
                        ": ${reason} \n" +
                        "Duration".tr() +
                        ": ${duration}",
                    textDirection: translator.activeLanguageCode == "en"
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    style: TextStyle(color: CustomColors.primary, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

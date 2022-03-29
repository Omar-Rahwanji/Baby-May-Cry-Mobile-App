import 'package:baby_may_cry/components/recorder_button.dart';
import 'package:baby_may_cry/services/api.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../components/player_button.dart';
import '../static/colors.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({Key? key}) : super(key: key);

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  String cryReason = "";
  final List<TextDirection> textDirection = [
    TextDirection.ltr,
    TextDirection.rtl
  ];

  void fetchCryReaon() async {
    final response = await getCryReason();
    setState(() {
      cryReason = response['cryReason'];
    });
  }

  @override
  void initState() {
    super.initState();

    fetchCryReaon();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
            height: 20,
          ),
          Text(
            "Hello, Parent".tr(),
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 60),
          Row(
            textDirection: translator.activeLanguageCode == "en"
                ? textDirection[0]
                : textDirection[1],
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your baby didn't cry since ".tr(),
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                ),
              ),
              Text(
                "30".tr(),
                style: TextStyle(
                  color: CustomColors.secondary,
                  fontSize: 20,
                ),
              ),
              Text(
                " min".tr(),
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: translator.activeLanguageCode == "en"
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Row(
              textDirection: translator.activeLanguageCode == "en"
                  ? textDirection[0]
                  : textDirection[1],
              children: [
                SizedBox(
                    width: translator.activeLanguageCode == "en" ? 52 : 75),
                Text(
                  "Last cry reason".tr(),
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
            cryReason.tr(),
            style: const TextStyle(
              fontSize: 42,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "Duration".tr(),
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: translator.activeLanguageCode == "en"
                ? textDirection[0]
                : textDirection[1],
            children: [
              Text(
                "30".tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                " min".tr(),
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          const RecorderButton(),
          const SizedBox(height: 60),
          const PlayerButton(),
        ],
      ),
    );
  }
}

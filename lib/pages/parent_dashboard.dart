import 'dart:async';

import 'package:baby_may_cry/components/recorder_button.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/player_button.dart';
import '../services/db.dart';
import '../static/colors.dart';
import 'crying_history.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({Key? key}) : super(key: key);
  static bool canFetchCryReason = true;
  static bool refreshLastCryTime = true;

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  Timer? _fetchingCryReasonTimer;
  Timer? _refreshLastCryTimeTimer;
  String cryReason = "";
  int lastCryDateTime = 0;
  String timeUnit = "min".tr();

  final List<TextDirection> textDirection = [
    TextDirection.ltr,
    TextDirection.rtl
  ];
  bool isLoadingCryReason = true;

  void fetchCryReason() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? parentEmail = prefs.getString("email");

    await FirestoreDb.getLastCryRecord(parentEmail!);
    await FirestoreDb.getCryRecords(parentEmail);
    refreshLastCryTime();

    setState(() {
      cryReason = prefs.getString("lastCryReason")!.tr();
      cryReason.toString().isEmpty
          ? isLoadingCryReason = true
          : isLoadingCryReason = false;
      CryingHistoryPage.cryingData = FirestoreDb.cryRecords;
    });
  }

  void refreshLastCryTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? parentEmail = prefs.getString("email");

    lastCryDateTime = DateTime.now()
        .difference(DateTime.parse(prefs.getString("lastCryDateTime")!))
        .inMinutes;
    if (lastCryDateTime / 60 >= 24) {
      lastCryDateTime = (lastCryDateTime / 60 / 24).floor();
      timeUnit = "day".tr();
    } else if (lastCryDateTime >= 60) {
      lastCryDateTime = (lastCryDateTime / 60).floor();
      timeUnit = "hour".tr();
    }
  }

  @override
  void initState() {
    super.initState();
    ParentDashboard.canFetchCryReason = true;
    ParentDashboard.refreshLastCryTime = true;

    _fetchingCryReasonTimer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (ParentDashboard.canFetchCryReason) {
        ParentDashboard.canFetchCryReason = false;
        fetchCryReason();
        setState(() {});
      }
    });

    _refreshLastCryTimeTimer =
        Timer.periodic(const Duration(minutes: 1), (timer) {
      refreshLastCryTime();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _fetchingCryReasonTimer!.cancel();
    _refreshLastCryTimeTimer!.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: screenHeight * 0.029,
          ),
          Text(
            "Hello, Parent".tr(),
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 30,
            ),
          ),
          SizedBox(height: screenHeight * 0.07),
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
                lastCryDateTime.toString(),
                style: TextStyle(
                  color: CustomColors.secondary,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  const Text(
                    " ",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    timeUnit,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
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
                  width: translator.activeLanguageCode == "en"
                      ? screenWidth * 0.133
                      : screenWidth * 0.2,
                ),
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
          SizedBox(height: screenHeight * 0.05),
          Visibility(
            visible: isLoadingCryReason,
            child: SizedBox(
              width: screenWidth * 0.5,
              child: const LinearProgressIndicator(),
            ),
          ),
          Visibility(
            visible: !isLoadingCryReason,
            child: Text(
              cryReason.tr(),
              style: const TextStyle(
                fontSize: 42,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.04),
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
                "6".tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                " " + "seconds".tr(),
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.07),
          const RecorderButton(),
          SizedBox(height: screenHeight * 0.07),
          const PlayerButton(),
          SizedBox(height: screenHeight * 0.02),
        ],
      ),
    );
  }
}

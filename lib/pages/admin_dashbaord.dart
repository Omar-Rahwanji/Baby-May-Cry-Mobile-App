import 'dart:async';

import 'package:baby_may_cry/components/reading_card.dart';
import 'package:baby_may_cry/services/db.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../static/colors.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool isLoadingAnalytics = true;
  Timer? _refreshLastCryTimeTimer;
  int numberOfParents = 0;
  int numberOfCryings = 0;

  final List<TextDirection> textDirection = [
    TextDirection.ltr,
    TextDirection.rtl
  ];

  void fetchAnalytics() async {
    await FirestoreDb.getNumberOfParents();
    await FirestoreDb.getNumberOfCryings();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      numberOfParents = prefs.getInt("numberOfParents")!;
      numberOfCryings = prefs.getInt("numberOfCryings")!;
      isLoadingAnalytics = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAnalytics();

    _refreshLastCryTimeTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) {
      fetchAnalytics();
    });
  }

  @override
  void dispose() {
    _refreshLastCryTimeTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ModalProgressHUD(
      inAsyncCall: isLoadingAnalytics,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.09,
            ),
            Text(
              "Hello, Admin".tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 30,
              ),
            ),
            SizedBox(height: screenHeight * 0.09),
            Text(
              "Live number of".tr(),
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReadingCard(
                  color: CustomColors.primary,
                  image: "parents.png",
                  label: "Parents",
                  reading: numberOfParents,
                  unit: " ",
                ),
                SizedBox(width: screenWidth * 0.1),
                ReadingCard(
                  color: CustomColors.secondary,
                  image: "baby-crying.png",
                  label: "Cryings",
                  reading: numberOfCryings,
                  unit: " ",
                ),
              ],
            ),
            // SizedBox(height: screenHeight * 0.01),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ReadingCard(
            //       color: CustomColors.primary,
            //       image: "pulse.png",
            //       label: "label",
            //       reading: "15",
            //       unit: "cm",
            //     ),
            //     SizedBox(width: screenWidth * 0.1),
            //     ReadingCard(
            //       color: CustomColors.primary,
            //       image: "pulse.png",
            //       label: "label",
            //       reading: "15",
            //       unit: "cm",
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

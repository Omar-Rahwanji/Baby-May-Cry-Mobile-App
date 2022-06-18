import 'dart:async';

import 'package:baby_may_cry/models/bar_chart_model.dart';
import 'package:baby_may_cry/services/db.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';

class CryingAnalyticsPage extends StatefulWidget {
  const CryingAnalyticsPage({Key? key}) : super(key: key);
  static var cryingData = [];

  @override
  State<CryingAnalyticsPage> createState() => _CryingAnalyticsPageState();
}

class _CryingAnalyticsPageState extends State<CryingAnalyticsPage> {
  Timer? _timer;
  List<int> numberOfcryReasons = [0, 0, 0, 0, 0];

  List<String> cryReasons = [
    "belly_pain",
    "burping",
    "discomfort",
    "hungry",
    "tired",
  ];

  void refreshCryingHistoryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int i = 0;
    for (String cryReason in cryReasons) {
      await FirestoreDb.getNumberOfCryReason(cryReason);
      numberOfcryReasons[i++] = prefs.getInt("numberOf" + cryReason)!;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      refreshCryingHistoryList();
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    List<BarChartModel> chartData = [
      BarChartModel(
        cryReason: "Belly pain",
        numberOfSounds: numberOfcryReasons[0],
        color: charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      BarChartModel(
        cryReason: "Burping",
        numberOfSounds: numberOfcryReasons[1],
        color: charts.ColorUtil.fromDartColor(Colors.yellow),
      ),
      BarChartModel(
        cryReason: "Discomfort",
        numberOfSounds: numberOfcryReasons[2],
        color: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      BarChartModel(
        cryReason: "Hungry",
        numberOfSounds: numberOfcryReasons[3],
        color: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      BarChartModel(
        cryReason: "Tired",
        numberOfSounds: numberOfcryReasons[4],
        color: charts.ColorUtil.fromDartColor(Colors.purple),
      ),
    ];

    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "Cry Analytics",
        data: chartData,
        domainFn: (BarChartModel series, _) => series.cryReason,
        measureFn: (BarChartModel series, _) => series.numberOfSounds,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Crying Analytics".tr()),
        centerTitle: true,
        elevation: 16,
      ),
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.9,
          child: charts.BarChart(
            series,
            animate: true,
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:baby_may_cry/models/bar_chart_model.dart';
import 'package:baby_may_cry/pages/admin_dashbaord.dart';
import 'package:baby_may_cry/services/db.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CryingAnalyticsPage extends StatefulWidget {
  const CryingAnalyticsPage({Key? key}) : super(key: key);
  static var cryingData = [];

  @override
  State<CryingAnalyticsPage> createState() => _CryingAnalyticsPageState();
}

class _CryingAnalyticsPageState extends State<CryingAnalyticsPage> {
  bool showSpinner = false;
  Timer? _timer;
  List<BarChartModel> chartData = [
    BarChartModel(
      cryReason: "hungry",
      numberOfSounds: 50,
      color: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    BarChartModel(
      cryReason: "discomfort",
      numberOfSounds: 30,
      color: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    BarChartModel(
      cryReason: "belly pain",
      numberOfSounds: 75,
      color: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    BarChartModel(
      cryReason: "burping",
      numberOfSounds: 15,
      color: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    BarChartModel(
      cryReason: "tired",
      numberOfSounds: 5,
      color: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
  ];

  void refreshCryingHistoryList() async {
    setState(() {
      CryingAnalyticsPage.cryingData = FirestoreDb.cryRecords;
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.9,
            child: charts.BarChart(
              series,
              animate: true,
            ),
          ),
        ),
      ),
    );
  }
}

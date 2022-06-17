import 'dart:async';

import 'package:baby_may_cry/services/db.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/crying_history_card.dart';

class CryingAnalyticsPage extends StatefulWidget {
  const CryingAnalyticsPage({Key? key}) : super(key: key);
  static var cryingData = [];

  @override
  State<CryingAnalyticsPage> createState() => _CryingAnalyticsPageState();
}

class _CryingAnalyticsPageState extends State<CryingAnalyticsPage> {
  bool showSpinner = false;
  Timer? _timer;
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Crying Analytics".tr()),
        centerTitle: true,
        elevation: 16,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView.builder(
          itemCount: CryingAnalyticsPage.cryingData.length,
          itemBuilder: (BuildContext context, int index) {
            String hour = TimeOfDay.fromDateTime(DateTime.parse(
                    CryingAnalyticsPage.cryingData[index]['dateTime']))
                .hourOfPeriod
                .toString();
            String minute = TimeOfDay.fromDateTime(DateTime.parse(
                    CryingAnalyticsPage.cryingData[index]['dateTime']))
                .minute
                .toString();
            ;
            if (int.parse(hour) < 10) {
              hour = "0" + hour;
            }
            if (int.parse(minute) < 10) {
              minute = "0" + minute;
            }

            return CryingHistoryCard(
              date: DateTime.parse(
                  CryingAnalyticsPage.cryingData[index]['dateTime']),
              time: hour.toString() + ":" + minute.toString(),
              reason: CryingAnalyticsPage.cryingData[index]['reason']
                  .toString()
                  .tr(),
              duration: "6".tr() + " " + "seconds".tr(),
              timeStamp: TimeOfDay.fromDateTime(DateTime.parse(
                      CryingAnalyticsPage.cryingData[index]['dateTime']))
                  .period
                  .name
                  .tr(),
            );
          },
        ),
      ),
    );
  }
}

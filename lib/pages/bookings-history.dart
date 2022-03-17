

import 'package:baby_may_cry/components/booking-history-card.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class BookingsHistoryPage extends StatelessWidget {
  BookingsHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookings history".tr()),
        centerTitle: true,
        elevation: 16,
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return BookingHistoryCard();
        },
      ),
    );
  }
}

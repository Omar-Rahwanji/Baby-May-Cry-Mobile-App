import '../static/colors.dart';
import 'package:flutter/material.dart';

class BookingHistoryCard extends StatelessWidget {
  const BookingHistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
         const  SizedBox(height: 10),
          Card(
            color: Colors.white,
            borderOnForeground: true,
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  isThreeLine: true,
                  leading:const  Icon(
                    Icons.airport_shuttle,
                    size: 50,
                  ),
                  title: Text(
                    "2022-3-2, Wednesday, 8:30 am",
                    style: TextStyle(color: CustomColors.primary),
                  ),
                  subtitle: Text(
                    "from: Jordan \nto: Palestine",
                    style:
                        TextStyle(color: CustomColors.secondary, fontSize: 18),
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

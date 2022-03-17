

import 'package:baby_may_cry/components/office-card.dart';
import 'package:baby_may_cry/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OfficesPage extends StatelessWidget {
  OfficesPage({Key? key}) : super(key: key);
  final offices = [
    {
      'headOffice': 'Head Office (Amman)',
      'street': 'Abdullah Ghosheh street, Building #38, 7th Floor, Office #702',
      'phoneNumber': translator.activeLanguageCode == "ar"
          ? ' 5854560/1 6 962'
          : ' +962 6 5854560/1',
      'fax': translator.activeLanguageCode == "ar"
          ? ' 585462 6 962'
          : ' +962 6 5854562',
    },
    {
      'headOffice': 'King Hussein Bridge (South Shouneh)',
      'phoneNumber': translator.activeLanguageCode == "ar"
          ? ' 3581655/6/7 5 962'
          : ' +962 5 3581655/6/7',
    },
    {
      'headOffice': 'Sheikh Hussein Bridge (North Shouneh)',
      'phoneNumber': translator.activeLanguageCode == "ar"
          ? ' 6550499 2 962'
          : ' +962 2 6550499',
      'fax': translator.activeLanguageCode == "ar"
          ? ' 6550488 2 962'
          : ' +962 2 6550488',
    }
  ];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  "Offices".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: CustomColors.secondary, fontSize: 25),
                ),
              ),
              OfficeCard(
                title: this.offices[0]['headOffice'],
                subtitle: this.offices[0]['street'],
                phoneNumber: this.offices[0]['phoneNumber'],
                fax: this.offices[0]['fax'],
              ),
              SizedBox(height: 50),
              OfficeCard(
                title: this.offices[1]['headOffice'],
                subtitle: '',
                phoneNumber: this.offices[1]['phoneNumber'],
                fax: '',
              ),
              SizedBox(height: 50),
              OfficeCard(
                title: this.offices[2]['headOffice'],
                subtitle: '',
                phoneNumber: this.offices[2]['phoneNumber'],
                fax: this.offices[2]['fax'],
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

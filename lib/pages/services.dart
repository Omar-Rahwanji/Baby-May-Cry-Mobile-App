

import 'package:baby_may_cry/components/service-card.dart';
import 'package:baby_may_cry/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ServicesPage extends StatefulWidget {
  ServicesPage({Key? key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  String? service = "King Hussein Bridge".tr();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                ServiceCard(
                  title: "VIP services includes",
                  subtitle: "",
                  details: [
                    "Private waiting lounge with free wifi",
                    "Assistance in document processing with priority",
                    "Assistance in luggage handling",
                    "Transportation between the 3 sides of the bridge in private cars"
                  ],
                ),
                // SizedBox(height: ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  color: CustomColors.primary,
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (translator.activeLanguageCode == "en")
                      Text("Choose the location".tr()),
                    SizedBox(width: 10),
                    DropdownButton(
                      isDense: true,
                      elevation: 16,
                      iconEnabledColor: CustomColors.primary,
                      value: this.service!.tr(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 26,
                      ),
                      items: [
                        "King Hussein Bridge".tr(),
                        "Sheikh Hussein Bridge".tr()
                      ].map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          this.service = newValue;
                        });
                      },
                    ),
                    if (translator.activeLanguageCode == "ar")
                      SizedBox(width: 10),
                    if (translator.activeLanguageCode == "ar")
                      Text("Choose the location".tr()),
                  ],
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  color: CustomColors.primary,
                  thickness: 3,
                ),
                SizedBox(height: 30),
                if (this.service == "King Hussein Bridge".tr())
                  ServiceCard(
                    title:
                        "VIP service prices in King Hussein Bridge (Allenby Bridge)",
                    subtitle:
                        "* VIP service prices for holders of Palestinian ID",
                    details: [
                      "\$149/person \nIncludes full VIP service on the Jordanian, Israeli and Palestinian sides",
                      "\$110/person \nIncludes full VIP service on the Jordanian and Palestinian sides, and only document processing without priority or use of private lounge on the Israeli side",
                      "Children from 3 to 16 years of age pay half the price and children below 3 years of age are served for free",
                      "We offer groups of 20 people and up special discounted price (Terms and conditions apply)"
                    ],
                  ),
                if (this.service == "King Hussein Bridge".tr())
                  SizedBox(height: 10),
                if (this.service == "King Hussein Bridge".tr())
                  ServiceCard(
                    title: "",
                    subtitle:
                        "*VIP service price for holders of Jerusalem ID an Foreign passports",
                    details: [
                      "\$115/person \nIncludes full VIP service on the Jordanian and Israeli sides",
                      "Children from 3 to 9 years of age pay half the price and children below 3 years of age are served for free",
                    ],
                  ),
                if (this.service == "Sheikh Hussein Bridge".tr())
                  ServiceCard(
                    title:
                        "VIP service prices in Sheikh Hussein Bridge (North Bridge)",
                    subtitle:
                        "* Fees paid include full VIP service on the Jordanian and Israeli sides\n* \$36 is added to each additional passenger",
                    details: [
                      "\$71 for 1 person",
                      "\$107 for 2 persons",
                      "\$143 for 3 persons",
                      "\$179 for 4 persons",
                    ],
                  ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

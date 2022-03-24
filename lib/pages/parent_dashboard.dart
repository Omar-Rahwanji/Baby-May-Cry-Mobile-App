import 'package:baby_may_cry/components/reading_card.dart';
import 'package:baby_may_cry/components/recording_button.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../static/colors.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({Key? key}) : super(key: key);

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
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
          const Text(
            "Hello, Parent",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 20),
          DropdownButton(
            elevation: 16,
            iconEnabledColor: CustomColors.primary,
            value: "device 3 - basel".tr(),
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 26,
            ),
            items: [
              "device 3 - basel".tr(),
              "device 2 - essam".tr(),
              "device 1 - omar".tr(),
            ].map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {},
          ),
          const SizedBox(height: 10),
          Row(
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
                "30 min".tr(),
                style: TextStyle(
                  color: CustomColors.secondary,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 285,
            child: Text(
              "Last cry reason".tr(),
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Text(
            "Hungry".tr(),
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
          RecordingButton(),
        ],
      ),
    );
  }
}

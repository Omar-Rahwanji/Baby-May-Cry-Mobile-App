

import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final Map<String, Object?> userData =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object?>;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile".tr()),
        centerTitle: true,
        elevation: 16,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
            width: screenWidth,
          ),
          CircleAvatar(
            child: ClipRect(
              child: Image.asset("assets/images/logo.png"),
            ),
            radius: 60,
            backgroundColor: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            userData['userName'].toString(),
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(height: 10),
          Text(
            userData['userPhoneNumber'].toString(),
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(height: 10),
          Text(
            userData['userEmail'].toString(),
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}

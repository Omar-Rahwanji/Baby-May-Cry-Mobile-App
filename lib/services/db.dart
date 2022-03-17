

import 'package:baby_may_cry/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreDb {
  static final FirebaseFirestore dbContext = FirebaseFirestore.instance;
  static late Map<String, String> userData = {};

  static Future<void> addUser() async {
    if (!AuthService.isLogged && userData.isNotEmpty)
      await dbContext
          .collection("users")
          .doc(AuthService.phoneNumber)
          .set(userData);
  }

  static Future<void> isLoggedUser() async {
    await dbContext
        .collection("users")
        .doc(AuthService.phoneNumber)
        .get()
        .then((value) {
      if (value.exists)
        AuthService.isLogged = true;
      else
        AuthService.isLogged = false;
    });
  }

  static Future<void> getUser(BuildContext context) async {
    return SharedPreferences.getInstance().then((prefs) {
      dbContext
          .collection("users")
          .doc(prefs.getString("userPhoneNumber"))
          .get()
          .then((user) {
        if (user.exists) {
          prefs.setString("userName",
              user.data()!['firstName'] + " " + user.data()!['lastName']);
          prefs.setString("userEmail", user.data()!['email']);
          prefs.setString("userPhoneNumber", user.data()!['phoneNumber']);
          print("user phone number= " +
              prefs.getString("userPhoneNumber").toString());
          Navigator.pushReplacementNamed(context, "/home", arguments: {
            'userName': prefs.getString("userName"),
            'userEmail': prefs.getString('userEmail'),
            'userPhoneNumber': prefs.getString("userPhoneNumber"),
          });
        }
      });
    });
  }
}

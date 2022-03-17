

import 'package:baby_may_cry/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;
  static String verificationId = "";
  static String phoneNumber = "";
  static bool isValidOTP = false;
  static bool isLogged = false;
  static String authState = "";
  static bool isExpiredOTP = false;

  static Future<void> login(BuildContext context) async {
    isLogged = false;
    try {
      await FirestoreDb.isLoggedUser().then((value) async {
        if (AuthService.isLogged)
          await AuthService.getOTP(context);
        else
          Fluttertoast.showToast(
            msg: "There is no account registered for this number".tr(),
            backgroundColor: Colors.red,
          );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> signup(BuildContext context) async {
    isLogged = false;
    try {
      await FirestoreDb.isLoggedUser().then((value) async {
        if (!AuthService.isLogged)
          await AuthService.getOTP(context);
        else
          Fluttertoast.showToast(
            msg: "There is already an account registered for this number".tr(),
            backgroundColor: Colors.red,
          );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> getOTP(BuildContext context) async {
    AuthService.isExpiredOTP = false;
    await auth
        .verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        print("Your phone number has been verified successfully!");
      },
      verificationFailed: (FirebaseAuthException authException) {
        print(authException.message);
        Fluttertoast.showToast(
          msg: "Please enter a valid number".tr(),
          backgroundColor: Colors.red,
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        AuthService.verificationId = verificationId;
        print("verificationId sent succefully");
        Navigator.pushNamed(
          context,
          "/otp",
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    )
        .catchError((e) {
      print(e);
      Fluttertoast.showToast(
        msg: "Please enter a valid number".tr(),
        backgroundColor: Colors.red,
      );
    });
  }

  static Future<void> verifyOTP(BuildContext context, String otp) async {
    if (AuthService.phoneNumber.isNotEmpty && !isExpiredOTP) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: AuthService.verificationId, smsCode: otp);
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          isValidOTP = true;
          SharedPreferences.getInstance().then((prefs) async {
            prefs.setBool("logged in", true);
            prefs.setString("userPhoneNumber", AuthService.phoneNumber);
            print("hello world");
            print(AuthService.isValidOTP);
            await FirestoreDb.addUser();
            await FirestoreDb.getUser(context);
          });
        } else
          isValidOTP = false;
      } catch (e) {
        print(e.toString() + " ppp");
        isValidOTP = false;
        Fluttertoast.showToast(
          msg: "You've entered a wrong code".tr(),
          backgroundColor: Colors.red,
        );
      }
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        msg: "The code is expired. Try again".tr(),
      );
    }
  }

  static void changePassword(BuildContext context, String newPassword) async {
    auth.currentUser?.updatePassword(newPassword).then(
      (_) {
        print("done updating password");
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/home",
          (route) => false,
        );
      },
    ).catchError(
      (e) {
        print("failed updating the password");
      },
    );
  }

  static void logout() async {
    await auth.signOut();
    await AuthService.resetAuth();
  }

  static Future<void> resetAuth() async {
    verificationId = "";
    phoneNumber = "";
    isValidOTP = false;
    isLogged = false;
    authState = "";
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setBool("logged in", false);
  }
}

import 'package:baby_may_cry/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;
  static String? currentUserEmail;
  static String? currentUserRole;

  static Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await FirestoreDb.getUserData(email);
        prefs.setBool("isLoggedIn", true);
        HomePage.userRole = prefs.getString("role")!;
        return true;
      }
    } catch (e) {
      print('hello ' + e.toString());
    }
    return false;
  }

  static Future<bool> signup(
      Map<String, String> userData, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: userData['email']!, password: password);
      if (userCredential.user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        prefs.setString("email", userData['email']!);
        prefs.setString("fullName", userData['fullName']!);
        prefs.setString("role", userData['role']!);
        return await FirestoreDb.addUser(userData);
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static void logout() async {
    await auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setBool("isLoggedIn", false);
  }
}

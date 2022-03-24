import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreDb {
  static final FirebaseFirestore dbContext = FirebaseFirestore.instance;
  static late Map<String, String> userData = {};

  static Future<bool> addUser(Map<String, String> userData) async {
    try {
      await dbContext.collection("users").doc(userData['email']).set(userData);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<void> getUserData(String email) async {
    await dbContext.collection("users").doc(email).get().then((user) async {
      if (user.exists) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("email", user.data()!['email']);
        prefs.setString("fullName", user.data()!['fullName']);
      }
    });
  }
}

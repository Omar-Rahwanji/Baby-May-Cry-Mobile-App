import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreDb {
  static final FirebaseFirestore dbContext = FirebaseFirestore.instance;
  static late List<Map<String, String>> cryRecords = [];

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

  static Future<bool> addCry(Map<String, String> cryRecord) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? parentEmail = prefs.getString("email");

      await dbContext.collection("cry").doc().set(cryRecord);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<void> getCryRecords(String parentEmail) async {
    await dbContext
        .collection("cry")
        .where("parentEmail", isEqualTo: parentEmail)
        .orderBy("dateTime")
        .get()
        .then((cryRecords) async {
      if (cryRecords.size > 0) {
        cryRecords.docs.forEach((element) {
          FirestoreDb.cryRecords.add({
            "dateTime": element.data()["dateTime"],
            "reason": element.data()["reason"],
          });
        });
        var lastCryRecord = cryRecords.docs.last.data();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("lastCryReason", lastCryRecord["reason"]);
        prefs.setString("lastCryDateTime", lastCryRecord["dateTime"]);
      }
    });
  }
}

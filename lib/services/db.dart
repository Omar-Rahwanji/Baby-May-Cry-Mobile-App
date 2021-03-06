import 'package:baby_may_cry/pages/admin_dashbaord.dart';
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
        prefs.setString("role", user.data()!['role']);
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

  static Future<void> getLastCryRecord(String parentEmail) async {
    FirestoreDb.cryRecords = [];
    await dbContext
        .collection("cry")
        .where("parentEmail", isEqualTo: parentEmail)
        .orderBy("dateTime", descending: true)
        .get()
        .then((cryRecords) async {
      if (cryRecords.size > 0) {
        var lastCryRecord = cryRecords.docs.first.data();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("lastCryReason", lastCryRecord["reason"]);
        prefs.setString("lastCryDateTime", lastCryRecord["dateTime"]);
      }
    });
  }

  static Future<void> getCryRecords(String parentEmail) async {
    FirestoreDb.cryRecords = [];
    await dbContext
        .collection("cry")
        .where("parentEmail", isEqualTo: parentEmail)
        .orderBy("dateTime", descending: true)
        .get()
        .then((cryRecords) async {
      if (cryRecords.size > 0) {
        cryRecords.docs.forEach((element) {
          FirestoreDb.cryRecords.add({
            "parentEmail": element.data()["parentEmail"],
            "dateTime": element.data()["dateTime"],
            "reason": element.data()["reason"],
          });
        });
      }
    });
  }

  static Future<void> getNumberOfParents() async {
    await dbContext
        .collection("users")
        .where("role", isEqualTo: "parent")
        .get()
        .then((parents) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("numberOfParents", parents.size);
    });
  }

  static Future<void> getNumberOfCryings() async {
    await dbContext.collection("cry").get().then((cryings) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("numberOfCryings", cryings.size);
    });
  }

  static Future<void> getNumberOfCryReason(String cryReason) async {
    FirestoreDb.cryRecords = [];
    await dbContext
        .collection("cry")
        .where("reason", isEqualTo: cryReason)
        .get()
        .then((cryRecords) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("numberOf" + cryReason, cryRecords.size);
    });
  }
}

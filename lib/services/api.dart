import 'dart:convert';
import 'dart:io';
import 'package:baby_may_cry/services/auth.dart';
import 'package:baby_may_cry/services/db.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/parent_dashboard.dart';

Future<Map<String, dynamic>> getCryReason() async {
  // http.Response cryReason = await http.get(Uri.parse('https://babymaycry.herokuapp.com'));
  http.Response cryReason = await http.get(Uri.parse('http://10.0.2.2:5000'));

  return json.decode(cryReason.body) as Map<String, dynamic>;
}

Future<bool> sendCrySound(String crySoundPath) async {
  // var headers = {'Content-Type': 'audio/wav'};
  var request = http.MultipartRequest(
    'POST',
    // Uri.parse('https://babymaycry.herokuapp.com'),
    Uri.parse('http://10.0.2.2:5000'),
  );

  request.fields['audioFileName'] = 'cry.wav';

  var soundFile = http.MultipartFile.fromBytes(
    'audio',
    (await File(crySoundPath).readAsBytes()),
    filename: 'cry.wav',
  );
  // request.headers.addAll(headers);

  request.files.add(soundFile);

  var response = await request.send();

  if (response.statusCode == 200) {
    var cryReason = await response.stream
        .toStringStream()
        .first
        .then((value) => json.decode(value)["cryReason"]);
    print(cryReason);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? parentEmail = prefs.getString("email");

    Map<String, String> cryRecord = {
      "parentEmail": parentEmail!,
      "reason": cryReason,
      "dateTime": DateTime.now().toString(),
    };
    FirestoreDb.addCry(cryRecord);
    Fluttertoast.showToast(
      msg: "Cry sound has been saved successfully".tr(),
      backgroundColor: Colors.green,
    );

    ParentDashboard.canFetchCryReason = true;
    return true;
  } else {
    print(response.reasonPhrase);
    Fluttertoast.showToast(
      msg: "Failed saving the cry sound".tr(),
      backgroundColor: Colors.red,
    );
    return false;
  }
}

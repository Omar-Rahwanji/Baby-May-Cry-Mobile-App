import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:localize_and_translate/localize_and_translate.dart';

Future<Map<String,dynamic>> getCryReason() async {
  http.Response cryReason = await http.get(Uri.parse('http://10.0.2.2:5000'));
  return json.decode(cryReason.body) as Map<String,dynamic>;
}

Future<bool> sendCrySound(String crySoundPath) async {
  // var headers = {'Content-Type': 'audio/wav'};
  var request = http.MultipartRequest(
    'POST',
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
    print(await response.stream.bytesToString());
    Fluttertoast.showToast(
      msg: "Your reservation has sent successfully".tr(),
      backgroundColor: Colors.green,
    );
    return false;
  } else {
    print(response.reasonPhrase);
    Fluttertoast.showToast(
      msg: "Failed sending your reservation".tr(),
      backgroundColor: Colors.red,
    );
    return false;
  }
}

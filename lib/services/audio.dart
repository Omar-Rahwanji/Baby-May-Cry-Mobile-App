import 'dart:convert';
import 'dart:io';

import 'package:baby_may_cry/pages/parent_dashboard.dart';
import 'package:baby_may_cry/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const audioFileName = "/cry.wav";

class SoundRecorder {
  static FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialised = false;

  bool get isRecording => _audioRecorder!.isRecording;

  late String audioFilePath;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();

    Directory? _downloadsDirectory = await getExternalStorageDirectory();
    audioFilePath = _downloadsDirectory!.path + audioFileName;

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission denied');
    }

    await _audioRecorder!.openAudioSession();
    _isRecorderInitialised = true;
  }

  void dispose() {
    if (!_isRecorderInitialised) return;

    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialised = false;
  }

  Future _record() async {
    if (!_isRecorderInitialised) return;
    await _audioRecorder!.startRecorder(toFile: audioFilePath);
  }

  Future _stop() async {
    if (!_isRecorderInitialised) return;

    String? audioFilePath = await _audioRecorder!.stopRecorder();

    print(this.audioFilePath);
    sendCrySound(this.audioFilePath).then((value) {
      ParentDashboard.canFetchCryReason = true;
    });
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped && SoundPlayer._audioPlayer!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}

class SoundPlayer {
  static FlutterSoundPlayer? _audioPlayer;
  bool _isPlayerInitialised = false;
  bool get isPlaying => _audioPlayer!.isPlaying;
  late String audioFilePath;

  Future init() async {
    _audioPlayer = FlutterSoundPlayer();

    Directory? _downloadsDirectory = await getExternalStorageDirectory();
    audioFilePath = _downloadsDirectory!.path + audioFileName;

    await _audioPlayer!.openAudioSession();
    _isPlayerInitialised = true;
  }

  void dispose() {
    if (!_isPlayerInitialised) return;

    _audioPlayer!.closeAudioSession();
    _audioPlayer = null;
    _isPlayerInitialised = false;
  }

  Future _play(VoidCallback whenFinished) async {
    await _audioPlayer!.startPlayer(
      fromURI: audioFilePath,
      whenFinished: whenFinished,
    );
  }

  Future _stop() async {
    await _audioPlayer!.stopPlayer();
  }

  Future togglePlaying({required VoidCallback whenFinished}) async {
    if (_audioPlayer!.isStopped && SoundRecorder._audioRecorder!.isStopped) {
      await _play(whenFinished);
    } else {
      await _stop();
    }
  }
}

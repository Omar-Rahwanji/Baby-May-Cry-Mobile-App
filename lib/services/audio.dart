import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const audioFilePath = "/cry.wav";

class SoundRecorder {
  static FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialised = false;

  bool get isRecording => _audioRecorder!.isRecording;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();

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
    Directory? _downloadsDirectory = await getExternalStorageDirectory();
    print(_downloadsDirectory!.path);
    await _audioRecorder!
        .startRecorder(toFile: _downloadsDirectory.path + audioFilePath);
  }

  Future _stop() async {
    if (!_isRecorderInitialised) return;

    await _audioRecorder!.stopRecorder();
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

  Future init() async {
    _audioPlayer = FlutterSoundPlayer();

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
    Directory? _downloadsDirectory = await getExternalStorageDirectory();

    await _audioPlayer!.startPlayer(
      fromURI: _downloadsDirectory!.path + audioFilePath,
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

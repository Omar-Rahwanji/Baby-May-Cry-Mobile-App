import 'package:baby_may_cry/services/audio.dart';
import 'package:baby_may_cry/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class RecorderButton extends StatefulWidget {
  const RecorderButton({Key? key}) : super(key: key);

  @override
  State<RecorderButton> createState() => _RecorderButtonState();
}

class _RecorderButtonState extends State<RecorderButton> {
  final recorder = SoundRecorder();
  final List<TextDirection> textDirection = [
    TextDirection.ltr,
    TextDirection.rtl
  ];

  @override
  void initState() {
    super.initState();
    recorder.init();
  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isRecording = recorder.isRecording;
    IconData icon = isRecording ? Icons.mic_outlined : Icons.mic_none_outlined;
    String buttonHint = isRecording ? "stop".tr() : "start".tr();

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.primary,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Stack(
            children: [
              Visibility(
                visible: isRecording,
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: CircularProgressIndicator(
                    backgroundColor: CustomColors.secondary,
                    strokeWidth: 7,
                  ),
                ),
              ),
              IconButton(
                enableFeedback: true,
                iconSize: 40,
                color: CustomColors.primary,
                icon: Icon(icon),
                onPressed: () async {
                  await recorder.toggleRecording();
                  isRecording = recorder.isRecording;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: translator.activeLanguageCode == "en"
              ? textDirection[0]
              : textDirection[1],
          children: [
            const SizedBox(width: 8),
            Text(
              "Press to ".tr(),
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
              ),
            ),
            Text(
              buttonHint,
              style: TextStyle(
                color: CustomColors.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              "recording".tr(),
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:baby_may_cry/services/audio.dart';
import 'package:baby_may_cry/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class PlayerButton extends StatefulWidget {
  const PlayerButton({Key? key}) : super(key: key);

  @override
  State<PlayerButton> createState() => _PlayerButtonState();
}

class _PlayerButtonState extends State<PlayerButton> {
  final player = SoundPlayer();
  final List<TextDirection> textDirection = [
    TextDirection.ltr,
    TextDirection.rtl
  ];

  @override
  void initState() {
    super.initState();
    player.init();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPlaying = player.isPlaying;
    IconData icon = isPlaying ? Icons.pause : Icons.play_arrow;
    String buttonHint = isPlaying ? "pause".tr() : "play".tr();

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
                visible: isPlaying,
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
                  await player.togglePlaying(
                      whenFinished: () => setState(() {}));
                  isPlaying = player.isPlaying;
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
              "sound".tr(),
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

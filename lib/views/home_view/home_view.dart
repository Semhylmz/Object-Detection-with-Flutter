import 'package:barrier_free_life/constants/color.dart';
import 'package:barrier_free_life/notifier/speech_to_text.dart';
import 'package:barrier_free_life/notifier/text_to_speech.dart';
import 'package:barrier_free_life/notifier/tflite_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'widgets/home_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer3<TfliteNotifier, SpeechToTextNotifier,
        TextToSpeechNotifier>(
      builder: (context, valueTflite, valueStt, valueTts, child) => Scaffold(
        backgroundColor: colorBg,
        body: Column(
          children: [
            HomeButton(
              size: size,
              icon: Icons.mic_none_outlined,
              callBack: () {
                valueStt.listening(isSuccess: () async {
                  valueTflite.changeFindState(value: true);
                  await valueTts
                      .speakMsg(
                          text:
                              'Successful, searched object ${valueStt.recognizeWord} redirecting to search page.')
                      .then(
                        (_) => context.goNamed('camera'),
                      );
                }, isFail: () async {
                  await valueTts.speakMsg(
                      text: 'Word not understood, please try again.');
                });
              },
            ),
            Divider(color: colorYlw),
            HomeButton(
              size: size,
              icon: Icons.camera_alt_outlined,
              callBack: () {
                valueTflite.changeFindState(value: false);
                context.goNamed('camera');
              },
            ),
          ],
        ),
      ),
    );
  }
}

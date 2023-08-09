import 'package:barrier_free_life/constants/color.dart';
import 'package:barrier_free_life/notifier/camera_notifier.dart';
import 'package:barrier_free_life/notifier/speech_to_text.dart';
import 'package:barrier_free_life/notifier/text_to_speech.dart';
import 'package:barrier_free_life/notifier/tflite_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _displaySplash();
    super.initState();
  }

  void _displaySplash() async {
    /// todo welcome text speak

    await Provider.of<TextToSpeechNotifier>(context, listen: false)
        .initTts()
        .then(
          (_) => Provider.of<TfliteNotifier>(context, listen: false)
              .initTfliteNotifier()
              .then(
                (_) => Provider.of<CameraNotifier>(context, listen: false)
                    .initCamera(context: context),
              )
              .then(
                (_) => Provider.of<SpeechToTextNotifier>(context, listen: false)
                    .initStt(context),
              )
              .then(
                (_) => context.goNamed('home'),
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBg,
      child: Center(
        child: CircularProgressIndicator(
          color: colorYlw,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

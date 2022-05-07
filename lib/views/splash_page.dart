import 'dart:async';
import 'package:flutter/material.dart';
import 'package:object_detection/views/home.dart';
import 'package:object_detection/tts/text_to_speech.dart';
import '../constans.dart';
import '../main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final TextToSpeech _textToSpeech = TextToSpeech();

  @override
  void initState() {
    super.initState();
    _textToSpeech.speak(splashText);
    _displaySplash();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.amber,
          backgroundColor: Colors.white,
          strokeWidth: 2,
        ),
      ),
    );
  }

  void _displaySplash() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(cameras),
        ),
      );
    });
  }
}

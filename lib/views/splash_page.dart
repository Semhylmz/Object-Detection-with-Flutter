import 'dart:async';
import 'package:flutter/material.dart';
import 'package:object_detection/views/home_view/home.dart';
import 'package:object_detection/tts/text_to_speech.dart';
import '../constants/constants.dart';
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
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/logo.png'), fit: BoxFit.contain),
      ),
      child: const Align(
        alignment: Alignment.bottomCenter,
        child: CircularProgressIndicator(
          color: Colors.blue,
          backgroundColor: Colors.white,
          strokeWidth: 2,
        ),
      ),
    );
  }

  void _displaySplash() {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(cameras),
          ),
        );
      },
    );
  }
}

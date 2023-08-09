import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechNotifier with ChangeNotifier {
  late FlutterTts tts;

  Future<void> initTts() async {
    tts = FlutterTts();
    await tts.setVolume(1.0);
    await tts.setPitch(1.0);
    await tts.setLanguage('en_EN');
    await tts.awaitSpeakCompletion(true);
  }

  Future<void> speakMsg({required String text}) async {
    await tts.speak(text);
    notifyListeners();
  }
}

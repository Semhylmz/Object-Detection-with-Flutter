import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MSpeechToText {
  //late stt.SpeechToText speech;
  static final _speech = SpeechToText();

  static Future<bool> MListening({
    required Function(String text) onResult,
    required ValueChanged<bool> onListening,
  }) async {
    if (_speech.isListening) {
      _speech.stop();
      return true;
    }

    final isAvailable = await _speech.initialize(
      onStatus: (status) => onListening(_speech.isListening),
      onError: (e) => print(e),
    );

    if (isAvailable) {
      _speech.listen(onResult: (val) => onResult(val.recognizedWords));
    }
    return isAvailable;
  }
}

import 'package:barrier_free_life/notifier/text_to_speech.dart';
import 'package:barrier_free_life/widgets/safe_print.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextNotifier with ChangeNotifier {
  late SpeechToText _speechToText;
  bool _isListening = false;
  late String _recognizeWord;
  late BuildContext _context;

  SpeechToText get speechToText => _speechToText;

  bool get isListening => _isListening;

  String get recognizeWord => _recognizeWord;

  void initStt(BuildContext context) async {
    _recognizeWord = '';
    _speechToText = SpeechToText();
    context = context;
    await _speechToText.initialize();
    notifyListeners();
  }

  void listening({
    required Function() isSuccess,
    required Function() isFail,
  }) async {
    safePrint('listening..');
    _isListening = true;
    _recognizeWord = '';
    _speechToText.listen(
      localeId: 'en_EN',
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.search,
      onResult: (result) async {
        _recognizeWord = '$_recognizeWord${result.recognizedWords}';
        _recognizeWord.isEmpty ? _isListening = false : isSuccess.call();
        safePrint('result $_recognizeWord');
        stopListening();
      },
    );
    notifyListeners();
  }

  void stopListening() async {
    _isListening = false;
    safePrint('stop listening..');
    await _speechToText.stop();
    notifyListeners();
  }
}

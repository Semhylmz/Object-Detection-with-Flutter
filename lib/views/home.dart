import 'package:avatar_glow/avatar_glow.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:object_detection/constans.dart';
import 'package:object_detection/tts/text_to_speech.dart';
import 'package:object_detection/views/camera_views.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomePage extends StatefulWidget {
  final List<CameraDescription>? cameras;

  const HomePage(this.cameras, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextToSpeech _textToSpeech = TextToSpeech();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    HapticFeedback.vibrate();
    _textToSpeech.speak(welcomeText);
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    _listen();
    super.dispose();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(
            () {
              textSearch = val.recognizedWords;
              if (val.hasConfidenceRating && val.confidence > 0) {
                confidence = val.confidence;
              }
              if (textSearch.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CameraView(widget.cameras, textSearch),
                  ),
                );
              }
            },
          ),
        );
      } else {
        setState(() {
          _isListening = false;
          _speech.stop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  SystemSoundType.click;
                  HapticFeedback.vibrate();
                  _listen();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: AvatarGlow(
                    animate: _isListening,
                    endRadius: 75,
                    duration: const Duration(milliseconds: 2000),
                    repeatPauseDuration: const Duration(milliseconds: 100),
                    repeat: true,
                    glowColor: Colors.amber,
                    child: Icon(
                      _isListening ? Icons.mic : Icons.mic_none_rounded,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(height: 70, color: Colors.amber),
            Text(
              textSearch +
                  '\n\nConfidence: ${(confidence * 100.0).toStringAsFixed(1)}%',
              style: const TextStyle(color: Colors.white),
            ),
            const Divider(height: 70, color: Colors.amber),
            Expanded(
              child: InkWell(
                onTap: () {
                  SystemSoundType.click;
                  HapticFeedback.vibrate();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraView(widget.cameras, 'tv'),
                    ),
                  );
                  _textToSpeech.speak(cameraText);
                  HapticFeedback.vibrate();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

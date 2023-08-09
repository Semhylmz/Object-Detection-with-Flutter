import 'package:barrier_free_life/notifier/camera_notifier.dart';
import 'package:barrier_free_life/notifier/speech_to_text.dart';
import 'package:barrier_free_life/notifier/text_to_speech.dart';
import 'package:barrier_free_life/notifier/tflite_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SpeechToTextNotifier()),
      ChangeNotifierProvider(create: (_) => TextToSpeechNotifier()),
      ChangeNotifierProvider(create: (_) => CameraNotifier()),
      ChangeNotifierProvider(create: (_) => TfliteNotifier()),
    ],
    child: const MyApp(),
  ));
}

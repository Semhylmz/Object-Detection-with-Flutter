import 'package:flutter/material.dart';
import 'package:object_detection/views/home.dart';
import 'package:object_detection/tts/text_to_speech.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constans.dart';
import '../main.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({Key? key}) : super(key: key);

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  final TextToSpeech _textToSpeech = TextToSpeech();

  @override
  void initState() {
    super.initState();
    _textToSpeech.speak(onBoardText);
  }

  _onBoardInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('onBoard', 1);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black12,
      child: InkWell(
        onTap: () {
          _onBoardInfo();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage(cameras)));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: const Icon(
            Icons.touch_app,
            color: Colors.amber,
            size: 50,
          ),
        ),
      ),
    );
  }
}

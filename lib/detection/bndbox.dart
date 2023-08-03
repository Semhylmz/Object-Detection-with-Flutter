import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../tts/text_to_speech.dart';

class BndBox extends StatefulWidget {
  final TextToSpeech _textToSpeech = TextToSpeech();

  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String search;

  BndBox(this.results, this.previewH, this.previewW, this.screenH, this.screenW,
      this.search,
      {Key? key})
      : super(key: key);

  @override
  State<BndBox> createState() => _BndBoxState();
}

class _BndBoxState extends State<BndBox> {
  bool _finded = false;
  final TextToSpeech _textToSpeech = TextToSpeech();

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBoxes() {
      widget.results.map((e) {
        _textToSpeech.speak("${e['detectedClass']}");
      });

      return widget.results.map((re) {
        var _x = re["rect"]["x"];
        var _w = re["rect"]["w"];
        var _y = re["rect"]["y"];
        var _h = re["rect"]["h"];
        var scaleW, scaleH, x, y, w, h;
        var confidence = double.parse("${re['confidenceInClass'] * 100}");

        for (var val in re.keys) {
          print("*********************\n" +
              val.toString() +
              "\n*********************");
        }

        if (widget.search.isNotEmpty) {
          if (widget.search == "${re['detectedClass']}" && confidence > 70) {
            setState(() {
              _finded = true;
            });
            if (_finded == true) {
              widget._textToSpeech.speak("${re['detectedClass']}");
              _finded = false;
              const Duration(seconds: 3);
            }
          }
        } else {
          if (confidence >= 60) {
            widget._textToSpeech.speak("${re['detectedClass']}");
            const Duration(seconds: 3);
          }
        }

        if (widget.screenH / widget.screenW >
            widget.previewH / widget.previewW) {
          scaleW = widget.screenH / widget.previewH * widget.previewW;
          scaleH = widget.screenH;
          var difW = (scaleW - widget.screenW) / scaleW;
          x = (_x - difW / 2) * scaleW;
          w = _w * scaleW;
          if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
          y = _y * scaleH;
          h = _h * scaleH;
        } else {
          scaleH = widget.screenW / widget.previewW * widget.previewH;
          scaleW = widget.screenW;
          var difH = (scaleH - widget.screenH) / scaleH;
          x = _x * scaleW;
          w = _w * scaleW;
          y = (_y - difH / 2) * scaleH;
          h = _h * scaleH;
          if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
        }

        return Positioned(
          left: math.max(0, x),
          top: math.max(0, y),
          width: w,
          height: h,
          child: Container(
            padding: const EdgeInsets.only(top: 5.0, left: 5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.amber,
                width: 1.0,
              ),
            ),
            child: Text(
              "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList();
    }

    return Stack(
      children: _renderBoxes(),
    );
  }
}

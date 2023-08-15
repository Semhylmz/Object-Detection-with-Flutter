import 'package:barrier_free_life/constants/color.dart';
import 'package:barrier_free_life/notifier/speech_to_text.dart';
import 'package:barrier_free_life/notifier/text_to_speech.dart';
import 'package:barrier_free_life/notifier/tflite_notifier.dart';
import 'package:barrier_free_life/widgets/safe_print.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';

class BndBox extends StatefulWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;

  const BndBox(
    this.results,
    this.previewH,
    this.previewW,
    this.screenH,
    this.screenW, {
    super.key,
  });

  @override
  State<BndBox> createState() => _BndBoxState();
}

class _BndBoxState extends State<BndBox> {
  late var scaleW, scaleH, x, y, w, h;
  double confidence = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.results.map((re) {
        var x0 = re["rect"]["x"];
        var w0 = re["rect"]["w"];
        var y0 = re["rect"]["y"];
        var h0 = re["rect"]["h"];

        safePrint(re['detectedClass']);

        confidence = double.parse("${re['confidenceInClass'] * 100}");
        confidence >= 60
            ? context.watch<TfliteNotifier>().isFind
                ? re["detectedClass"].contains(
                        context.watch<SpeechToTextNotifier>().recognizeWord)
                    ? context.watch<TextToSpeechNotifier>().speakMsg(
                        text:
                            '${context.watch<SpeechToTextNotifier>().recognizeWord} finded')
                    : context
                        .watch<TextToSpeechNotifier>()
                        .speakMsg(text: 'searching')
                : context
                    .watch<TextToSpeechNotifier>()
                    .speakMsg(text: re["detectedClass"])
            : null;

        if (widget.screenH / widget.screenW >
            widget.previewH / widget.previewW) {
          scaleW = widget.screenH / widget.previewH * widget.previewW;
          scaleH = widget.screenH;
          var difW = (scaleW - widget.screenW) / scaleW;
          x = (x0 - difW / 2) * scaleW;
          w = w0 * scaleW;
          if (x0 < difW / 2) w -= (difW / 2 - x0) * scaleW;
          y = y0 * scaleH;
          h = h0 * scaleH;
        } else {
          scaleH = widget.screenW / widget.previewW * widget.previewH;
          scaleW = widget.screenW;
          var difH = (scaleH - widget.screenH) / scaleH;
          x = x0 * scaleW;
          w = w0 * scaleW;
          y = (y0 - difH / 2) * scaleH;
          h = h0 * scaleH;
          if (y0 < difH / 2) h -= (difH / 2 - y0) * scaleH;
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
                color: colorYlw,
                width: 1.0,
              ),
            ),
            child: Text(
              "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
              style: TextStyle(
                color: colorYlw,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

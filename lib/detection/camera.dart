import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:object_detection/tts/text_to_speech.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

typedef void Callback(List<dynamic> list, int h, int w);

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;

  //final String model;

  Camera(this.cameras, this.setRecognitions);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController? controller;
  bool isDetecting = false;
  final TextToSpeech _textToSpeech = TextToSpeech();

  @override
  void initState() {
    super.initState();
    if (widget.cameras.isEmpty) {
      _textToSpeech.speak('No Cameras Found');
    } else {
      controller = CameraController(
        widget.cameras[0],
        ResolutionPreset.high,
      );
      controller?.initialize().then(
        (_) {
          if (!mounted) {
            return;
          }
          setState(() {});
          controller?.startImageStream(
            (CameraImage img) {
              if (!isDetecting) {
                isDetecting = true;
                Tflite.detectObjectOnFrame(
                  bytesList: img.planes.map((plane) {
                    return plane.bytes;
                  }).toList(),
                  model: "SSDMobileNet",
                  imageHeight: img.height,
                  imageWidth: img.width,
                  imageMean: 127.5,
                  imageStd: 127.5,
                  numResultsPerClass: 1,
                  threshold: 0.4,
                ).then(
                  (recognitions) {
                    if (recognitions == null) {
                      return;
                    }
                    widget.setRecognitions(recognitions, img.height, img.width);
                    isDetecting = false;
                  },
                );
              }
            },
          );
        },
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller?.value.previewSize ?? MediaQuery.of(context).size;

    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller!),
    );
  }
}

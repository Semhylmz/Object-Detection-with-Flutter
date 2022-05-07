import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:object_detection/detection/bndbox.dart';
import 'package:object_detection/detection/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

class CameraView extends StatefulWidget {
  final List<CameraDescription>? cameras;
  final String _searchText;

  const CameraView(this.cameras, this._searchText, {Key? key})
      : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {

  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;

  @override
  void initState() {
    super.initState();
    HapticFeedback.vibrate();
    loadModel();
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/ssd_mobilenet.tflite",
      labels: "assets/ssd_mobilenet.txt",
    );
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Camera(widget.cameras!, setRecognitions),
          BndBox(
            _recognitions == null ? [] : _recognitions!,
            math.max(_imageHeight, _imageWidth),
            math.min(_imageHeight, _imageWidth),
            screen.height,
            screen.width,
            widget._searchText,
          ),
          Center(
            child: TextButton(
              child: Container(
                color: Colors.black.withOpacity(0.1),
                width: screen.width * 0.4,
                height: screen.height * 0.2,
                child: const Icon(
                  Icons.touch_app,
                  color: Colors.amber,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

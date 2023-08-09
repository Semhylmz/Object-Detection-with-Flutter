import 'package:barrier_free_life/constants/constans.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class TfliteNotifier with ChangeNotifier {
  late List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  bool _isDetecting = false;
  bool _isFind = false;

  List<dynamic> get recognitions => _recognitions;

  int get imageHeight => _imageHeight;

  int get imageWidth => _imageWidth;

  bool get isDetecting => _isDetecting;

  bool get isFind => _isFind;

  void changeFindState({required bool value}) {
    _isFind = value;
    notifyListeners();
  }

  Future<void> initTfliteNotifier() async {
    _recognitions = [];
    await Tflite.loadModel(
      model: modelAsset,
      labels: modelLabel,
    );
    notifyListeners();
  }

  void detectOnFrame({required CameraImage img}) {
    _isDetecting = true;
    Tflite.detectObjectOnFrame(
      bytesList: img.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      model: 'SSDMobileNet',
      imageHeight: img.height,
      imageWidth: img.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResultsPerClass: 2,
      threshold: 0.4,
    ).then(
      (value) {
        value == null
            ? null
            : addRecognitions(recognitions, imageHeight, imageWidth);
      },
    );
  }

  void addRecognitions(recognitions, imageHeight, imageWidth) {
    _recognitions = recognitions;
    _imageHeight = imageHeight;
    _imageWidth = imageWidth;
    _isDetecting = false;
    notifyListeners();
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class CameraWidgets extends StatefulWidget {
  const CameraWidgets({super.key, required this.cameraController});

  final CameraController cameraController;

  @override
  State<CameraWidgets> createState() => _CameraWidgetsState();
}

class _CameraWidgetsState extends State<CameraWidgets> {
  @override
  Widget build(BuildContext context) {
    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = widget.cameraController.value.previewSize ??
        MediaQuery.of(context).size;

    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;
    return OverflowBox(
        maxHeight: screenRatio > previewRatio
            ? screenH
            : screenW / previewW * previewH,
        maxWidth: screenRatio > previewRatio
            ? screenH / previewH * previewW
            : screenW,
        child: CameraPreview(widget.cameraController));
  }
}

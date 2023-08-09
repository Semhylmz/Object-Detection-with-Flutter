import 'package:barrier_free_life/views/camera_view/widgets/bnd_box.dart';
import 'package:barrier_free_life/notifier/tflite_notifier.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../constants/color.dart';
import 'widgets/camera_widget.dart';
import 'dart:math' as math;

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, required this.cameraController});

  final CameraController cameraController;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Consumer<TfliteNotifier>(
        builder: (context, valueTflite, child) => SafeArea(
          child: Stack(
            children: [
              CameraWidgets(
                cameraController: widget.cameraController,
              ),
              BndBox(
                valueTflite.recognitions,
                math.max(valueTflite.imageHeight, valueTflite.imageWidth),
                math.min(valueTflite.imageHeight, valueTflite.imageWidth),
                screen.height,
                screen.width,
              ),
              GestureDetector(
                onTap: () {
                  context.goNamed('home');
                },
                child: Container(
                  color: colorBg.withOpacity(0.1),
                  width: screen.width,
                  height: screen.height,
                  child: Icon(
                    Icons.touch_app,
                    color: colorYlw,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:barrier_free_life/notifier/tflite_notifier.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CameraNotifier with ChangeNotifier {
  late List<CameraDescription> _cameras;
  late CameraDescription _cameraDescription;
  late CameraController _cameraController;

  List<CameraDescription> get cameras => _cameras;

  CameraDescription get cameraDescription => _cameraDescription;

  CameraController get cameraController => _cameraController;

  void disposeMethod() {
    _cameraController.dispose();
    notifyListeners();
  }

  Future<void> initCamera({required BuildContext context}) async {
    _cameras = await availableCameras();
    final tfliteNotifier = Provider.of<TfliteNotifier>(context, listen: false);
    _cameraController = CameraController(
      _cameras[0],
      ResolutionPreset.max,
    );
    _cameraController.initialize().then(
      (_) {
        _cameraController.startImageStream(
          (CameraImage img) {
            if (!tfliteNotifier.isDetecting) {
              tfliteNotifier.detectOnFrame(img: img);
            }
          },
        );
      },
    ).catchError(
      (Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      },
    );
    _cameraDescription = _cameraController.description;
  }
}

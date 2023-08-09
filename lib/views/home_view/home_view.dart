import 'package:barrier_free_life/constants/color.dart';
import 'package:barrier_free_life/notifier/camera_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../camera_view/camera_view.dart';
import 'widgets/home_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    //Provider.of<CameraNotifier>(context, listen: false).disposeMethod();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<CameraNotifier>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: colorBg,
        body: Column(
          children: [
            HomeButton(
              size: size,
              icon: Icons.mic_none_outlined,
              callBack: () {},
            ),
            Divider(color: colorYlw),
            HomeButton(
              size: size,
              icon: Icons.camera_alt_outlined,
              callBack: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CameraPage(
                //       cameraController:
                //           Provider.of<CameraNotifier>(context, listen: false)
                //               .cameraController,
                //     ),
                //   ),
                // );
                context.goNamed('camera');
              },
            ),
          ],
        ),
      ),
    );
  }
}

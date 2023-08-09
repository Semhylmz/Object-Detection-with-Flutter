import 'package:barrier_free_life/views/home_view/home_view.dart';
import 'package:barrier_free_life/views/camera_view/camera_view.dart';
import 'package:barrier_free_life/views/splash_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../notifier/camera_notifier.dart';
import '../../views/not_found_view.dart';

enum AppRoute {
  root,
  splash,
  home,
  camera;

  get getRoute => {
        AppRoute.root: AppRoute.root.getRoute,
        AppRoute.splash: AppRoute.splash.getRoute,
        AppRoute.home: AppRoute.home.getRoute,
        AppRoute.camera: AppRoute.camera.getRoute,
      }[this]!;
}

final appRoute = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/camera',
      name: 'camera',
      builder: (context, state) {
        return Consumer<CameraNotifier>(
            builder: (context, valueCameraNotifier, child) {
          return CameraPage(
            cameraController: valueCameraNotifier.cameraController,
          );
        });
      },
    ),
  ],
  errorBuilder: (context, state) => const NotFoundPage(),
);

GoRouter get getGoRouter => appRoute;

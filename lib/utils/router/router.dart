import 'package:barrier_free_life/views/home_view/home_view.dart';
import 'package:barrier_free_life/views/camera_view/camera_view.dart';
import 'package:barrier_free_life/views/settings_view.dart';
import 'package:barrier_free_life/views/splash_view.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/not_found_view.dart';

enum AppRoute {
  root,
  splash,
  home,
  camera,
  settings;

  get getRoute => {
        AppRoute.root: AppRoute.root.getRoute,
        AppRoute.splash: AppRoute.splash.getRoute,
        AppRoute.home: AppRoute.home.getRoute,
        AppRoute.camera: AppRoute.camera.getRoute,
        AppRoute.settings: AppRoute.settings.getRoute,
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
        //final valueCameraNotifier = Provider.of<CameraNotifier>(context, listen: false);
        return const CameraPage(
            //cameraController: valueCameraNotifier.cameraController,
            );
      },
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
  errorBuilder: (context, state) => const NotFoundPage(),
);

GoRouter get getGoRouter => appRoute;

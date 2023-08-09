import 'package:barrier_free_life/constants/color.dart';
import 'package:barrier_free_life/utils/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: colorBg,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return MaterialApp.router(
      title: 'Barrier-free Life',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          background: colorBg,
          seedColor: colorYlw,
        ),
      ),
      //home: const SplashPage(),
      routerConfig: appRoute,
      //routerDelegate: appRoute.routerDelegate,
    );
  }
}

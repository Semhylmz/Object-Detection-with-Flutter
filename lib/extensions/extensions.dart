import 'dart:io';
import 'package:flutter/cupertino.dart';

extension AppExtensions on BuildContext {
  String get getDeviceLanguage => Platform.localeName;
}

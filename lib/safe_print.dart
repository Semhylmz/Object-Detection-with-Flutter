import 'package:flutter/foundation.dart';

void safePrint(String msg) {
  if (kDebugMode) print(msg);
}

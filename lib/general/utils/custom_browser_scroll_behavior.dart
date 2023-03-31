import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomBrowserScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

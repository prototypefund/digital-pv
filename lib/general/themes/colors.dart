import 'package:flutter/material.dart';

mixin DefaultThemeColors {
  static const Color black = Color.fromARGB(255, 15, 10, 57);
  static const Color blackTransparent = Color.fromARGB(153, 15, 10, 57);

  static const Color darkGrey = Color.fromARGB(255, 55, 71, 97);
  static Color grey = Colors.grey.shade500;
  // static const Color grey2 = Color.fromARGB(255, 123, 120, 144);
  static Color lightGrey = Colors.grey.shade300;
  static Color mediumGrey = Colors.grey.shade400;
  static const Color darkGreyTransparent = Color.fromARGB(76, 55, 71, 97);

  static const Color lightWhite = Color.fromRGBO(243, 243, 242, 1);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color darkWhite = Colors.white24;

  static const Color purple = Color.fromARGB(255, 124, 55, 250);
  static const Color magenta = Color.fromRGBO(255, 0, 131, 1);
  static const Color lightMagenta = Color.fromRGBO(251, 0, 112, 1);
  static const Color darkMagenta = Color.fromRGBO(211, 0, 110, 0.5);
  static const Color veryDarkMagenta = Color.fromRGBO(255, 0, 112, 0.2);

  static Color lightCyan = const Color(0xffA2E5D5).withOpacity(0.4);
  static const Color cyan = Color.fromARGB(255, 123, 211, 191);
  static const Color brownGrey = Color(0xffBBB0A9);
  static const Color blue = Color(0xffCCDEFF);
  static const Color darkBlue = Color.fromARGB(255, 80, 112, 174);
}

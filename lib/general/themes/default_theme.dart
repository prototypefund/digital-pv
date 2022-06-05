import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

mixin DefaultTheme {
  ThemeData get defaultTheme => ThemeData(
      fontFamily: "Roboto",
      primaryColor: const Color.fromARGB(255, 124, 55, 250),
      backgroundColor: Colors.white,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 124, 55, 250))),
      textTheme: Typography.blackCupertino.merge(TextTheme(
          headlineLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: DefaultThemeColors.black),
          bodyLarge: TextStyle(fontSize: 18.sp, color: DefaultThemeColors.grey, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontSize: 16.sp, color: DefaultThemeColors.grey, fontWeight: FontWeight.normal))));
}

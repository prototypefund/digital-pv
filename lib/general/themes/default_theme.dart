import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

const Duration defaultDuration = Duration(milliseconds: 200);

mixin DefaultTheme {
  ThemeData get defaultTheme => ThemeData(
      fontFamily: "Roboto",
      scaffoldBackgroundColor: Colors.white,
      primaryColor: const Color.fromARGB(255, 124, 55, 250),
      backgroundColor: Colors.white,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: 16.sp, color: DefaultThemeColors.grey, fontWeight: FontWeight.normal),
              elevation: 0)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 124, 55, 250),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 0,
              textStyle: TextStyle(fontSize: 16.sp, color: DefaultThemeColors.grey, fontWeight: FontWeight.normal))),
      textTheme: Typography.blackCupertino.merge(TextTheme(
          headlineLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: DefaultThemeColors.black),
          bodyLarge: TextStyle(fontSize: 18.sp, color: DefaultThemeColors.grey, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontSize: 16.sp, color: DefaultThemeColors.grey, fontWeight: FontWeight.normal))));
}

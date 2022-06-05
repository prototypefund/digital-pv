import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';

mixin DefaultTheme {
  ThemeData get defaultTheme => ThemeData(
      fontFamily: "Roboto",
      primaryColor: DefaultThemeColors.white,
      backgroundColor: DefaultThemeColors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 16, color: DefaultThemeColors.white, fontWeight: FontWeight.bold),
              primary: DefaultThemeColors.purple)),
      textTheme: Typography.blackCupertino.merge(const TextTheme(
          headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: DefaultThemeColors.black),
          bodyLarge: TextStyle(fontSize: 16, color: DefaultThemeColors.grey, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontSize: 16, color: DefaultThemeColors.grey, fontWeight: FontWeight.normal))));
}

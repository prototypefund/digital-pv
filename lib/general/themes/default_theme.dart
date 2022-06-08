import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';

mixin DefaultTheme {
  ThemeData get defaultTheme => ThemeData(
      fontFamily: "Roboto",
      primaryColor: DefaultThemeColors.white,
      backgroundColor: DefaultThemeColors.white,
      inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: DefaultThemeColors.purple)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: DefaultThemeColors.purple))),
      sliderTheme: SliderThemeData(
          overlayShape: SliderComponentShape.noThumb,
          activeTrackColor: DefaultThemeColors.darkGrey,
          inactiveTrackColor: DefaultThemeColors.darkGreyTransparent,
          thumbColor: DefaultThemeColors.darkGrey),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 16, color: DefaultThemeColors.white, fontWeight: FontWeight.bold),
              primary: DefaultThemeColors.purple)),
      textTheme: Typography.blackCupertino.merge(const TextTheme(
          headlineLarge:
              TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: DefaultThemeColors.black, height: 32 / 24),
          bodyLarge: TextStyle(fontSize: 16, color: DefaultThemeColors.grey, fontWeight: FontWeight.normal),
          titleMedium:
              TextStyle(fontSize: 20, color: DefaultThemeColors.black, fontWeight: FontWeight.w300, height: 32 / 20),
          labelLarge:
              TextStyle(fontSize: 16, color: DefaultThemeColors.black, fontWeight: FontWeight.bold, height: 24 / 16),
          labelMedium: TextStyle(
              fontSize: 13, color: DefaultThemeColors.blackTransparent, fontWeight: FontWeight.normal, height: 18 / 13),
          labelSmall: TextStyle(
              fontSize: 11, color: DefaultThemeColors.blackTransparent, fontWeight: FontWeight.normal, height: 15 / 11),
          bodyMedium: TextStyle(fontSize: 16, color: DefaultThemeColors.grey, fontWeight: FontWeight.normal))));
}

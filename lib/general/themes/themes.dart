import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/themes/extensions/page_indicator_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

const Duration defaultDuration = Duration(milliseconds: 200);

class Themes {
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
                textStyle: TextStyle(fontSize: 14.sp, color: DefaultThemeColors.white, fontWeight: FontWeight.bold),
                backgroundColor: DefaultThemeColors.purple)),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                foregroundColor: DefaultThemeColors.purple,
                textStyle: TextStyle(fontSize: 16.sp, color: DefaultThemeColors.white, fontWeight: FontWeight.bold))),
        textTheme: Typography.blackCupertino.merge(TextTheme(
            headlineLarge: TextStyle(
                fontSize: 15.sp, fontWeight: FontWeight.bold, color: DefaultThemeColors.black, height: 32 / 24),
            headlineMedium: TextStyle(
                fontSize: 14.sp, fontWeight: FontWeight.w300, color: DefaultThemeColors.black, height: 32 / 20),
            bodyLarge: TextStyle(fontSize: 15.sp, color: DefaultThemeColors.grey, fontWeight: FontWeight.normal),
            titleMedium: TextStyle(
                fontSize: 14.sp, color: DefaultThemeColors.black, fontWeight: FontWeight.w300, height: 32 / 20),
            labelLarge: TextStyle(
                fontSize: 14.sp, color: DefaultThemeColors.black, fontWeight: FontWeight.bold, height: 24 / 16),
            labelMedium: TextStyle(
                fontSize: 13.sp,
                color: DefaultThemeColors.blackTransparent,
                fontWeight: FontWeight.normal,
                height: 18 / 13),
            labelSmall: TextStyle(
                fontSize: 11.sp,
                color: DefaultThemeColors.blackTransparent,
                fontWeight: FontWeight.normal,
                height: 15 / 11),
            bodyMedium: TextStyle(fontSize: 14.sp, color: DefaultThemeColors.grey, fontWeight: FontWeight.normal))),
        extensions: const <ThemeExtension<dynamic>>[
          PageIndicatorStyle(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              color: DefaultThemeColors.purple,
            ),
          ),
        ],
      );
}

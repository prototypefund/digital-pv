import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/themes/extensions/aspect_visualization_style.dart';
import 'package:pd_app/general/themes/extensions/dropdown_button_style.dart';
import 'package:pd_app/general/themes/extensions/page_indicator_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

const Duration defaultDuration = Duration(milliseconds: 200);

class Themes {
  ThemeData get defaultTheme => ThemeData(
        appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: DefaultThemeColors.purple)),
        fontFamily: "Roboto",
        colorScheme: ColorScheme.fromSeed(seedColor: DefaultThemeColors.purple),
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
          headlineLarge:
              TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: DefaultThemeColors.black, height: 32 / 24),
          headlineMedium:
              TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: DefaultThemeColors.black, height: 32 / 20),
          headlineSmall:
              TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: DefaultThemeColors.black, height: 32 / 20),
          titleLarge:
              TextStyle(fontSize: 16.sp, color: DefaultThemeColors.black, fontWeight: FontWeight.bold, height: 32 / 20),
          titleMedium:
              TextStyle(fontSize: 16.sp, color: DefaultThemeColors.black, fontWeight: FontWeight.w300, height: 32 / 20),
          titleSmall:
              TextStyle(fontSize: 14.sp, color: DefaultThemeColors.black, fontWeight: FontWeight.w300, height: 32 / 20),
          bodyLarge: TextStyle(fontSize: 15.sp, color: DefaultThemeColors.grey, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontSize: 14.sp, color: DefaultThemeColors.grey, fontWeight: FontWeight.normal),
          labelLarge:
              TextStyle(fontSize: 14.sp, color: DefaultThemeColors.black, fontWeight: FontWeight.bold, height: 24 / 16),
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
        )),
        extensions: <ThemeExtension<dynamic>>[
          const PageIndicatorStyle(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              color: DefaultThemeColors.purple,
            ),
          ),
          DropdownButtonStyle(
              textStyle: TextStyle(
                  color: DefaultThemeColors.purple, fontSize: 10.sp, fontWeight: FontWeight.normal, height: 15 / 11),
              underlineColor: Colors.deepPurpleAccent,
              underlineHeight: 2.sp),
          AspectVisualizationStyle(
            sectionLabelStyle:
                const TextStyle(color: DefaultThemeColors.purple, fontSize: 14, fontWeight: FontWeight.bold, height: 1),
            tendencyLabelStyle: const TextStyle(
                color: DefaultThemeColors.purple, fontSize: 14, fontWeight: FontWeight.normal, height: 1),
            aspectEvaluationArrowStrokeWidth: 4,
            aspectEvaluationArrowColor: DefaultThemeColors.purple,
            treatmentGoalArrowStrokeWidth: 12,
            treatmentGoalArrowColor: Colors.red,
            aspectCircleGradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 1,
              colors: [DefaultThemeColors.white.withOpacity(0.5), DefaultThemeColors.purple.withOpacity(0.5)],
            ),
          )
        ],
      );
}

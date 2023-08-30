import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/themes/extensions/aspect_visualization_style.dart';
import 'package:pd_app/general/themes/extensions/dropdown_button_style.dart';
import 'package:pd_app/general/themes/extensions/page_indicator_style.dart';

const Duration defaultDuration = Duration(milliseconds: 200);

class Themes {
  ThemeData get defaultTheme => ThemeData(
        appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: DefaultThemeColors.magenta)),
        fontFamily: "Roboto",
        colorScheme: ColorScheme.fromSeed(seedColor: DefaultThemeColors.magenta),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: DefaultThemeColors.magenta)),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: DefaultThemeColors.magenta)),
          labelStyle: TextStyle(
              color: Colors.grey.shade400, height: 1, fontSize: 16, fontFamily: GoogleFonts.openSans().fontFamily),
        ),
        sliderTheme: SliderThemeData(
            overlayShape: SliderComponentShape.noThumb,
            activeTrackColor: DefaultThemeColors.darkGrey,
            inactiveTrackColor: DefaultThemeColors.darkGreyTransparent,
            thumbColor: DefaultThemeColors.darkGrey),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                textStyle: const TextStyle(fontSize: 14, color: DefaultThemeColors.white, fontWeight: FontWeight.bold),
                backgroundColor: DefaultThemeColors.magenta)),
        iconTheme: const IconThemeData(color: DefaultThemeColors.magenta),
        tabBarTheme: const TabBarTheme(
          labelColor: DefaultThemeColors.white,
          unselectedLabelColor: DefaultThemeColors.darkGrey,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: DefaultThemeColors.purple),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          labelPadding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.transparent,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: DefaultThemeColors.magenta),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                foregroundColor: DefaultThemeColors.magenta,
                textStyle:
                    const TextStyle(fontSize: 16, color: DefaultThemeColors.white, fontWeight: FontWeight.bold))),
        textTheme: Typography.blackCupertino
            .merge(TextTheme(
              headlineLarge: GoogleFonts.merriweather(fontSize: 42, fontWeight: FontWeight.w400, letterSpacing: -1.5),
              headlineMedium: GoogleFonts.merriweather(fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: -0.5),
              headlineSmall: GoogleFonts.merriweather(fontSize: 30, fontWeight: FontWeight.w400),
              titleLarge: GoogleFonts.merriweather(fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
              titleMedium: GoogleFonts.merriweather(fontSize: 23, fontWeight: FontWeight.w400),
              titleSmall: GoogleFonts.merriweather(fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
              bodyLarge: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.w400, letterSpacing: 0.5),
              bodyMedium: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.w400, letterSpacing: 0.25),
              bodySmall: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.25),
              labelLarge: GoogleFonts.openSans(fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: 0.25),
              labelMedium: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.25),
              labelSmall: GoogleFonts.openSans(fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 0.25),
            ))
            .apply(
              displayColor: const Color.fromRGBO(74, 74, 77, 1),
              bodyColor: const Color.fromRGBO(74, 74, 77, 1),
            ),
        extensions: <ThemeExtension<dynamic>>[
          const PageIndicatorStyle(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              color: DefaultThemeColors.magenta,
            ),
          ),
          const DropdownButtonStyle(
              textStyle: TextStyle(color: DefaultThemeColors.magenta, fontSize: 14, fontWeight: FontWeight.normal),
              underlineColor: Colors.deepPurpleAccent,
              underlineHeight: 2),
          AspectVisualizationStyle(
            backgroundColor: Colors.white,
            sectionLabelStyle: const TextStyle(
                color: DefaultThemeColors.magenta, fontSize: 14, fontWeight: FontWeight.bold, height: 1),
            tendencyLabelStyle: const TextStyle(
                color: DefaultThemeColors.magenta, fontSize: 14, fontWeight: FontWeight.normal, height: 1),
            aspectEvaluationArrowStrokeWidth: 4,
            aspectEvaluationArrowColor: DefaultThemeColors.magenta,
            treatmentGoalArrowStrokeWidth: 12,
            treatmentGoalArrowColor: Colors.red,
            activeAspectCircleGradient: RadialGradient(
              center: Alignment.center,
              radius: 1,
              colors: [DefaultThemeColors.white.withOpacity(0.5), DefaultThemeColors.magenta],
            ),
            inactiveAspectCircleGradient: RadialGradient(
              center: Alignment.center,
              radius: 1,
              colors: [DefaultThemeColors.white.withOpacity(0.5), DefaultThemeColors.grey.withOpacity(0.2)],
            ),
          )
        ],
      );
}

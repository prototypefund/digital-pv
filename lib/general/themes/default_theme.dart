import 'package:flutter/material.dart';

mixin DefaultTheme {
  ThemeData get defaultTheme => ThemeData(
      fontFamily: "Roboto",
      primaryColor: Colors.white,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 124, 55, 250))),
      textTheme: const TextTheme(caption: TextStyle(color: Colors.black)));
}

//

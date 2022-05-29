import 'package:flutter/material.dart';

mixin DefaultTheme {
  ThemeData get defaultTheme => ThemeData(
      fontFamily: "Roboto",
      primaryColor: Colors.blue,
      appBarTheme: const AppBarTheme(color: Colors.blue),
      textTheme: const TextTheme(caption: TextStyle(color: Colors.black)));
}

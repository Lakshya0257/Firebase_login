import 'package:flutter/material.dart';

class MyTheme{
  static ThemeData light_theme(BuildContext context)=>ThemeData(
    primarySwatch: Colors.yellow,
    fontFamily: 'Schyler',
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
  );

  static ThemeData dark_theme(BuildContext context)=>ThemeData(
    primarySwatch: Colors.yellow,
    fontFamily: 'Schyler',
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
  );
}
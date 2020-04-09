import 'package:flutter/material.dart';

class Themes
{
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.red,
    accentColor: Colors.red,
    backgroundColor: Colors.grey[850],
    fontFamily: 'GoogleSans'
  );

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.red,
    accentColor: Colors.red,
    backgroundColor: Colors.white,
    fontFamily: 'GoogleSans'
  );

  static ThemeData current = dark;
}
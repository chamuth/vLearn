import 'package:flutter/material.dart';

class Themes
{
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.red,
    accentColor: Colors.red,
    fontFamily: 'GoogleSans'
  );

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'GoogleSans'
  );

  static ThemeData current;
}
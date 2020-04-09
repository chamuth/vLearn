import 'package:elearnapp/Core/ThemeNotifier.dart';
import 'package:flutter/material.dart';

class Themes
{
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueAccent[200],
    accentColor: Colors.blueAccent[200],
    backgroundColor: Colors.grey[850],
    fontFamily: 'GoogleSans'
  );

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blueAccent[200],
    accentColor: Colors.blueAccent[200],
    backgroundColor: Colors.white,
    fontFamily: 'GoogleSans'
  );

  static ThemeNotifier themeNotifier;
  static bool darkMode = false;
}
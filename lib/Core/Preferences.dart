import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences
{
  static SharedPreferences prefs;
  static bool temporaryColorSwitching = false;
  
  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void setColors(themeNotifier)
  {
      if (!Preferences.prefs.getBool("darkMode") ?? true) 
      {
        if (!Preferences.temporaryColorSwitching)
        {
          FlutterStatusbarcolor.setStatusBarColor(Colors.white);
          FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
          FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
          FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
        }

        themeNotifier.setTheme(Themes.light);
        Themes.darkMode = false;
      } else {
        if (!Preferences.temporaryColorSwitching)
        {
          FlutterStatusbarcolor.setStatusBarColor(Colors.grey[850]);
          FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
          FlutterStatusbarcolor.setNavigationBarColor(Colors.grey[850]);
          FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
        }

        themeNotifier.setTheme(Themes.dark);
        Themes.darkMode = true;
      }
  }

}
import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.light
        ));
      }

      themeNotifier.setTheme(Themes.light);
      Themes.darkMode = false;
    } else {
      if (!Preferences.temporaryColorSwitching)
      {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.grey[850],
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.grey[850],
          systemNavigationBarIconBrightness: Brightness.dark
        ));
      }

      themeNotifier.setTheme(Themes.dark);
      Themes.darkMode = true;
    }
  }

}
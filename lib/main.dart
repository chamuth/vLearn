import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './Themes/themes.dart';
import './Screens/start.dart';
import './Core/Preferences.dart';
import 'Screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void updateTheme()
  {
    Preferences.initialize().then((a)
    {
      if (!Preferences.prefs.containsKey("darkMode"))
        Preferences.prefs.setBool("darkMode", false);

      if (!Preferences.prefs.getBool("darkMode")) 
      {
        FlutterStatusbarcolor.setStatusBarColor(Colors.white);
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);

        Themes.current = Themes.light;
      } else {
        FlutterStatusbarcolor.setStatusBarColor(Colors.grey[850]);
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        FlutterStatusbarcolor.setNavigationBarColor(Colors.grey[850]);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);

        Themes.current = Themes.dark;
      }
    });
  }

  @override
  Widget build(BuildContext context) 
  {
    updateTheme();    

    return MaterialApp(
      title: 'eLearn',
      theme: Themes.current,
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

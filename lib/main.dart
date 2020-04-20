import 'package:elearnapp/Questionaires/MCQ.dart';
import 'package:elearnapp/Screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './Themes/themes.dart';
import './Core/Preferences.dart';
import './Screens/start.dart';
import './Screens/login.dart';
import 'Core/ThemeNotifier.dart';
import 'Screens/Register/register.dart';
import 'Questionaires/MCQ.dart';

void main() => runApp(
  ChangeNotifierProvider<ThemeNotifier>(
    child: MyApp(), create: (BuildContext context) { return ThemeNotifier(Themes.light); },
  ),
);

class MyApp extends StatelessWidget {
  void updateTheme(themeNotifier)
  {
    Preferences.initialize().then((a)
    {
      Preferences.prefs.setBool("darkMode", true);
      
      if (!Preferences.prefs.getBool("darkMode") ?? true) 
      {
        FlutterStatusbarcolor.setStatusBarColor(Colors.white);
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);

        themeNotifier.setTheme(Themes.light);
        Themes.darkMode = false;
      } else {
        FlutterStatusbarcolor.setStatusBarColor(Colors.grey[850]);
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        FlutterStatusbarcolor.setNavigationBarColor(Colors.grey[850]);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);

        themeNotifier.setTheme(Themes.dark);
        Themes.darkMode = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) 
  {
    Themes.themeNotifier = Provider.of<ThemeNotifier>(context);
    
    updateTheme(Themes.themeNotifier);

    return MaterialApp(
      title: 'vLearn',
      theme: Themes.themeNotifier.getTheme(),
      home: MCQScreen(),
      routes: <String, WidgetBuilder>{
        '/login' : (BuildContext context) => LoginScreen(),
        '/dashboard' : (BuildContext context) => StartScreen(),
        '/register' : (BuildContext context) => RegisterScreen(),
        '/test' : (BuildContext context) => MCQScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

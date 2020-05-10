import 'package:elearnapp/Questionaires/MCQ.dart';
import 'package:elearnapp/Screens/Register/register2.dart';
import 'package:elearnapp/Screens/Represents/JoinClass.dart';
import 'package:elearnapp/Screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './Themes/themes.dart';
import './Core/Preferences.dart';
import './Screens/start.dart';
import './Screens/login.dart';
import 'Core/ThemeNotifier.dart';
import 'Questionaires/CreateMCQ.dart';
import 'Screens/Register/register.dart';
import 'Questionaires/MCQ.dart';
import 'Screens/Register/register3.dart';
import 'Screens/Represents/ClassView.dart';
import 'Screens/Represents/ConversationThreadView.dart';
import 'Screens/Represents/ProfileView.dart';

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
      Preferences.setColors(themeNotifier);
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
      home: SplashScreen(),
      
      routes: <String, WidgetBuilder>{
        '/login' : (BuildContext context) => LoginScreen(),
        '/dashboard' : (BuildContext context) => StartScreen(),
        '/register' : (BuildContext context) => RegisterScreen(),
        '/test' : (BuildContext context) => MCQScreen(),
        '/class' : (BuildContext context) => ClassView(),
      },

      debugShowCheckedModeBanner: false,
    );
  }
}

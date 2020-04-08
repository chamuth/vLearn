import 'package:shared_preferences/shared_preferences.dart';

class Preferences
{
  static SharedPreferences prefs;
  
  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
  }
}
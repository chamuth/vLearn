import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Themes/themes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import './Tabs/chat.dart';
import './Tabs/dashboard.dart';
import './Tabs/folder.dart';
import './Tabs/notifications.dart';
import './Tabs/settings.dart';
import 'Tabs/timetable.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key key, this.startupIndex = 0}) : super(key: key);

  int startupIndex = 0;

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  List<Widget> tabs  = <Widget>[DashboardTab(), FolderTab(), ChatTab(), TimetableTab(), SettingsTab()]; 
  List<String> tabNames = ["Dashboard", "Shared Folder", "Chats", "Timetable", "Settings"];
  List<IconData> tabIcons = [Icons.dashboard, Icons.folder_shared, Icons.chat, Icons.table_chart, Icons.settings];
  int selectedIndex = 0;
  double pageOpacity = 1;

  @override
  void initState() 
  {
    // Count for user activity
    User.setLastOnline(User.me.uid, DateTime.now());
    
    setState(() {
      selectedIndex = widget.startupIndex;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items:  List.generate(tabs.length, (i){
          return BottomNavigationBarItem(title: Text(tabNames[i]), icon: Icon(tabIcons[i], size: 25));
        }),
        elevation: 1,
        currentIndex: selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: (Themes.darkMode) ? Colors.grey : Colors.grey,
        onTap: (index) {
          //Handle button tap
          setState(() {
            pageOpacity = 0;

            Future.delayed(const Duration(milliseconds: 150), () {
              setState(() {
                selectedIndex = index;
                pageOpacity = 1;
              });
            });

            log("Selected" + index.toString());
          });
        },
      ),
      appBar: MainAppBar.get(context, tabNames[selectedIndex]),
      body: AnimatedOpacity(opacity: pageOpacity, duration: Duration(milliseconds:150), child: Container(child: tabs[selectedIndex], color: (Themes.darkMode) ? Colors.grey[850] : Colors.white)),
    
    );
  }
}
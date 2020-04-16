import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import './Tabs/chat.dart';
import './Tabs/dashboard.dart';
import './Tabs/folder.dart';
import './Tabs/notifications.dart';
import './Tabs/settings.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  List<Widget> tabs  = <Widget>[DashboardTab(), FolderTab(), ChatTab(), NotificationsTab(), SettingsTab()]; 
  int selectedIndex = 0;
  double pageOpacity = 1;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(title: Text("Dashboard"), icon: Icon(Icons.dashboard, size: 25)),
          BottomNavigationBarItem(title: Text("Shared Folder"), icon: Icon(Icons.folder_shared, size: 25)),
          BottomNavigationBarItem(title: Text("Chats"), icon: Icon(Icons.chat, size: 25)),
          BottomNavigationBarItem(title: Text("Notifications"), icon: Icon(Icons.notifications, size: 25)),
          BottomNavigationBarItem(title: Text("Settings"), icon: Icon(Icons.settings, size: 25)),
        ],
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
      appBar: MainAppBar.get(context),
      body: AnimatedOpacity(opacity: pageOpacity, duration: Duration(milliseconds:150), child: Container(child: tabs[selectedIndex], color: (Themes.darkMode) ? Colors.grey[850] : Colors.white)),
    
    );
  }
}
import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import './Tabs/chat.dart';
import './Tabs/dashboard.dart';
import './Tabs/folder.dart';
import './Tabs/notifications.dart';
import './Tabs/profile.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  List<Widget> tabs  = <Widget>[DashboardTab(), FolderTab(), ChatTab(), NotificationsTab(), ProfileTab()]; 
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    if (Themes.darkMode)
      FlutterStatusbarcolor.setNavigationBarColor(Colors.grey[800]);

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey[850],
        color:Colors.grey[800],
        height:53,
        animationDuration: Duration(milliseconds: 200),
        items: <Widget>[
          Icon(Icons.dashboard, size: 30),
          Icon(Icons.folder_shared, size: 30),
          Icon(Icons.chat, size: 30),
          Icon(Icons.notifications, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
          setState(() {
            selectedIndex = index;
            log("Selected" + index.toString());
          });
        },
      ),
      appBar:AppBar(
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(11),
          child: new RawMaterialButton(
            onPressed: () { log("Profile clicked"); },
            child: CircleAvatar(
              backgroundColor: Colors.red,
              foregroundColor: Colors.black,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () { log("search button clicked"); }, tooltip: "Search entire space",),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 5, 0), 
            child: Badge(
              badgeContent: Text("3"),
              position: BadgePosition.topRight(top: 1, right: 1), 
              child: IconButton(
                icon: Icon(Icons.notifications), 
                onPressed: () { log("notifications button clicked"); }, tooltip: "Show notifications",
              )
            )
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: tabs[selectedIndex]
    
    );
  }
}
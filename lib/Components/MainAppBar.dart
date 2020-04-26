import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/material.dart';

class MainAppBar
{
  static AppBar get(BuildContext context, String title, { bool poppable = false } )
  {
    return AppBar(
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(11),
          child: (!poppable) ? new RawMaterialButton(
            onPressed: () { log("Profile clicked"); },
            child: CircleAvatar(
              child: Icon(Icons.person_outline, color: Colors.white, size: 20),
              backgroundColor: (Themes.darkMode) ? Colors.grey[700] : Theme.of(context).primaryColor,
              foregroundColor: Colors.black,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
          ) : new IconButton(
            onPressed: () { Navigator.of(context).maybePop(); },
            icon: Icon(Icons.arrow_back),
          ),
        ),

        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: (Themes.darkMode) ? Colors.grey[300] : Theme.of(context).primaryColor)),

        actions: <Widget>[
          if (!poppable)
            IconButton(icon: Icon(Icons.search), onPressed: () { log("search button clicked"); }, tooltip: "Search entire space", color: (Themes.darkMode) ? Colors.white : Colors.grey[800],),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 5, 0), 
            child: Badge(
              badgeContent: Text("3", style: TextStyle(color:  Colors.white)),
              position: BadgePosition.topRight(top: 1, right: 1), 
              badgeColor: Theme.of(context).primaryColor,
              child: IconButton(
                color: (Themes.darkMode) ? Colors.white : Colors.grey[800],
                icon: Icon(Icons.notifications), 
                onPressed: () { log("notifications button clicked"); }, tooltip: "Show notifications",
              )
            )
          ),
        ],
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      );
  }
}
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/material.dart';

class NotificationsTab extends StatefulWidget {
  NotificationsTab({Key key}) : super(key: key);

  @override
  NotificationsTabState createState() => NotificationsTabState();
}

class NotificationsTabState extends State<NotificationsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.get(context, "Notifications", poppable: true),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Icon(Icons.notifications_none, size: 45, color: (!Themes.darkMode) ? Theme.of(context).primaryColor : Colors.grey[300]),
          Divider(color: Colors.transparent, height: 15),
          Text("Not to worry", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: (!Themes.darkMode) ? Theme.of(context).primaryColor : Colors.white),),
          Divider(color: Colors.transparent, height: 2),
          Text("You have no notifications", style: TextStyle(color: Colors.grey, fontSize: 15))
        ],)
      )
    );
  }
}
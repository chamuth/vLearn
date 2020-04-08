import 'package:flutter/material.dart';

class NotificationsTab extends StatefulWidget {
  NotificationsTab({Key key}) : super(key: key);

  @override
  NotificationsTabState createState() => NotificationsTabState();
}

class NotificationsTabState extends State<NotificationsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("Notifications"),
    );
  }
}
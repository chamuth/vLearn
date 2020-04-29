import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/material.dart';

class Register3Screen extends StatefulWidget {
  Register3Screen({Key key}) : super(key: key);

  @override
  _Register3ScreenState createState() => _Register3ScreenState();
}

class _Register3ScreenState extends State<Register3Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (color: Theme.of(context).backgroundColor, child: Center(child: ListView(shrinkWrap: true, children: <Widget>[

        Padding(child: Column(children: <Widget>[

          Icon(Icons.calendar_today, size: 60, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor),
          Divider(color: Colors.transparent, height: 15),
          Text(
            "Hey Chamuth!", 
            textAlign: TextAlign.center, 
            style: TextStyle(fontSize: 25, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor)
          ),
          Divider(color: Colors.transparent, height: 8),
          Text(
            "We need some more information about you to get started", 
            textAlign: TextAlign.center, 
            style: TextStyle(fontSize: 20, color: Colors.grey)
          ),

          Divider(color: Colors.transparent, height: 20),
          
          

        ],), padding: EdgeInsets.fromLTRB(45, 0, 45, 0),)

      ],)),)
    );
  }
}
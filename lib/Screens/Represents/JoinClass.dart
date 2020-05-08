import 'dart:ui';

import 'package:elearnapp/Components/ClassItem.dart';
import 'package:elearnapp/Core/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JoinClassScreen extends StatefulWidget {
  JoinClassScreen({Key key}) : super(key: key);

  @override
  _JoinClassScreenState createState() => _JoinClassScreenState();
}

class _JoinClassScreenState extends State<JoinClassScreen> {

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 50), ()
    {
      Preferences.temporaryColorSwitching = true;
      
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ));  
    });

    super.initState();
  }

  @override
  void dispose() {
    Preferences.temporaryColorSwitching = false;

    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[

        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://khanlabschool.org/sites/default/files/img/Khan-Lab-School-with-Khan-Academy.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: 
            new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: new Container(
                decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
        ),

        Opacity(child: Container(color: Colors.black), opacity: 0.75),

        Center(child: ListView(shrinkWrap: true, children: <Widget>[
          
          Center(child: Stack(children: <Widget>[
            Padding(child: CircleAvatar(radius: 35, backgroundImage: NetworkImage("https://1.bp.blogspot.com/-9yDQk5VYLyE/XXtJcG4K7kI/AAAAAAAADQA/ikeFKLP5I1wSsUhB6J4-Gwb7s-wSdc4IgCNcBGAsYHQ/s400/Screenshot_20190911-234830_Multi%2BParallel-min.jpg"),), padding: EdgeInsets.fromLTRB(60, 0, 0, 0)),

            Container(child: CircleAvatar(radius: 35, backgroundImage: NetworkImage("https://chicagophotovideo.com/wp-content/uploads/2018/01/linkedin-professional-profile-photographer-chicago-il-1024x683.jpg"),), 
            decoration: new BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.7), blurRadius: 50.0, spreadRadius: 0.0, offset: Offset(5,0))
              ],
            ),)
          ],)),

          Divider(color: Colors.transparent, height: 25),

          Text("You're invited", style: TextStyle(fontSize: 30, color: Colors.white), textAlign: TextAlign.center,),

          Divider(color: Colors.transparent, height: 10),

          Padding(child: RichText(text: TextSpan(children: <TextSpan>[
            TextSpan(text: "Mrs. Sandra Korvacs", style: TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold)),
            TextSpan(text: " sent an invitation for you to join a class,", style: TextStyle(color: Colors.grey))
          ], style: TextStyle(fontFamily: "GoogleSans")), textAlign: TextAlign.center,),padding: EdgeInsets.fromLTRB(50, 0, 50, 0),),

          Divider(color: Colors.transparent, height: 20),

          Padding(child: ClassItem(subject: "Chemistry", grade: "Grade 13",hostName: "Mrs. Sandra Korvacs"), padding: EdgeInsets.fromLTRB(25, 0, 25, 0),),

          Divider(color: Colors.transparent, height: 20),

          Padding(child: RichText(text: TextSpan(children: <TextSpan>[
            TextSpan(text: "You can follow the link anytime even though you've Ignored the invitation right now.", style: TextStyle( fontFamily: "GoogleSans", color: Colors.grey))
          ]), textAlign: TextAlign.center,),padding: EdgeInsets.fromLTRB(50, 0, 50, 0),),

          Divider(color: Colors.transparent, height: 30),

          Padding(child: Row(children: <Widget>[
            Expanded(child: OutlineButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Text("ACCEPT INVITE", style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {

              },
              color: Colors.white,
              textColor: Colors.white,
              borderSide: BorderSide(color: Colors.white),
              highlightedBorderColor: Colors.grey,
            ),),
            VerticalDivider(width:10, color: Colors.transparent),
            Expanded(child: OutlineButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Text("IGNORE", style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              color: Colors.red,
              textColor: Colors.red,
              borderSide: BorderSide(color: Colors.red),
              highlightedBorderColor: Colors.red.withOpacity(0.5),
            ),)
          ],), padding: EdgeInsets.fromLTRB(45, 0, 45, 0),)

        ],),)

      ],)
    );
  }
}
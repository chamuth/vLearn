import 'dart:ui';

import 'package:elearnapp/Components/ClassItem.dart';
import 'package:elearnapp/Core/Classes.dart';
import 'package:elearnapp/Core/Invite.dart';
import 'package:elearnapp/Core/Preferences.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JoinClassScreen extends StatefulWidget {
  JoinClassScreen({Key key, this.invite}) : super(key: key);

  String invite;

  @override
  _JoinClassScreenState createState() => _JoinClassScreenState();
}

class _JoinClassScreenState extends State<JoinClassScreen> {

  @override
  void initState() {

    if (User.me.teacher)
    {
      Navigator.pop(context);
    }

    Future.delayed(Duration(milliseconds: 50), ()
    {
      Preferences.temporaryColorSwitching = true;
      
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ));  
    });

    if (widget.invite == null)
    {
      Future.delayed(Duration(seconds:1), () {
        scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              "The invite link you entered is invalid. Please request the class host for a new invite link", 
              style:TextStyle(color: Colors.white)
            ),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'EXIT',
              textColor: Colors.grey[400],
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
            duration: Duration(seconds: 50),
          )
        );
      });
    } else {
      Invite.processInvite(widget.invite).then((value) {
        setState(() {
          wait = false;
          classData = value["classData"];
          host = value["host"];
        });
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    Preferences.temporaryColorSwitching = false;

    super.dispose();
  }

  bool wait = true;
  ClassData classData;
  User host;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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

        Opacity(child: Container(color: Colors.black), opacity: (wait) ? 0.9 : 0.75),

        AnimatedOpacity(child: Center(child: ListView(shrinkWrap: true, children: <Widget>[
          
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
            TextSpan(text: User.getSanitizedName(host), style: TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold)),
            TextSpan(text: " sent an invitation for you to join a class,", style: TextStyle(color: Colors.grey))
          ], style: TextStyle(fontFamily: "GoogleSans")), textAlign: TextAlign.center,),padding: EdgeInsets.fromLTRB(50, 0, 50, 0),),

          Divider(color: Colors.transparent, height: 20),

          Padding(child: ClassItem(subject: classData.subject, grade: classData.grade, hostName: User.getSanitizedName(host)), padding: EdgeInsets.fromLTRB(25, 0, 25, 0),),

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

        ],),),duration: Duration(milliseconds: 150), opacity: (wait) ? 0.2 : 1,),

        AnimatedOpacity(child: Center(child: CircularProgressIndicator()), duration: Duration(milliseconds: 250), opacity: (!wait) ? 0 : 1)

      ],)
    );
  }
}
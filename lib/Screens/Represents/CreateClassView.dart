import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Core/Preferences.dart';
import '../../Core/User.dart';
import 'ClassView.dart';

class CreateClassView extends StatefulWidget {
  CreateClassView({Key key}) : super(key: key);

  @override
  _CreateClassViewState createState() => _CreateClassViewState();
}

class _CreateClassViewState extends State<CreateClassView> {
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

  TextEditingController subjectController = new TextEditingController();
  TextEditingController gradeController = new TextEditingController();

  bool submitting = false;

  void createClass()
  {
    setState(() {
      submitting = true;
    });

    User.getMyOrg().collection("classes").add({
      "grade" : gradeController.text,
      "subject" : subjectController.text,
      "host" : User.me.uid,
    }).then((value) {
      Navigator.push(context, CupertinoPageRoute(builder: (context) => ClassView(classId: value.documentID)));
    });
  }

  submittable()
  {
    if (subjectController.text.trim() != "" && gradeController.text.trim() != "")
    {
      return createClass;
    }
  }
  
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(children: <Widget>[
        
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/add-classroom-background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: new Container(
            decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
          ),
        ),

        Opacity(child: Container(color: Colors.black), opacity: 0.70),

        Center(child: Padding(child: Card(clipBehavior: Clip.antiAlias, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Stack(children: <Widget>[
          AnimatedOpacity(child: ListView(shrinkWrap: true, children: <Widget>[
            Icon(Icons.group_add, size: 40, color: Colors.grey[400]),
            Divider(color: Colors.transparent, height: 5),
            Center(child: Text("CREATE CLASSROOM", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[400]))),
            Divider(color: Colors.transparent, height: 10),

            Padding(
              child: Stack(children: <Widget>[
                TextField(
                  controller: subjectController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always, 
                    labelText: 'Subject Title',
                    contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                    labelStyle: TextStyle(fontSize: 20, color: Colors.grey[300]),
                    alignLabelWithHint: true,
                    suffixIcon: AnimatedOpacity(child: Padding(child: Icon(Icons.done, color: Colors.green, size: 20), padding: EdgeInsets.fromLTRB(15,10,0,0)), opacity:0, duration: Duration(milliseconds: 100)),
                    helperText: "Subject that is going to be taught in this class"
                  )
                ),
                IgnorePointer(ignoring:true, child: AnimatedOpacity(child: Padding(child: Text("Eg:- Physics (Advanced Level)", style: TextStyle(color: Colors.grey[600])), padding: EdgeInsets.fromLTRB(0, 26, 0, 0),), duration: Duration(milliseconds: 100), opacity: (subjectController.text == "") ? 1 : 0),),
              ],),
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            ),
            Padding(
              child: Stack(children: <Widget>[
                TextField(
                  controller: gradeController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always, 
                    labelText: 'Class Grade',
                    contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                    labelStyle: TextStyle(fontSize: 20, color: Colors.grey[300]),
                    alignLabelWithHint: true,
                    suffixIcon: AnimatedOpacity(child: Padding(child: Icon(Icons.done, color: Colors.green, size: 20), padding: EdgeInsets.fromLTRB(15,10,0,0)), opacity:0, duration: Duration(milliseconds: 100)),
                    helperText: "Grade the class is intended for"
                  )
                ),
                IgnorePointer(ignoring:true, child: AnimatedOpacity(child: Padding(child: Text("Eg:- Grade 12", style: TextStyle(color: Colors.grey[600])), padding: EdgeInsets.fromLTRB(0, 26, 0, 0),), duration: Duration(milliseconds: 100), opacity: (gradeController.text == "") ? 1 : 0),),
              ],),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            ),

            Divider(color: Colors.transparent, height: 10),

            Padding(child: RaisedButton(child: Text("Create Class"), onPressed: submittable(), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),), padding: EdgeInsets.fromLTRB(15,0,15,5)),

            Divider(color: Colors.transparent, height: 10),

          ],), opacity: submitting ? 0.1 : 1, duration: Duration(milliseconds: 150),),

          if (submitting) CircularProgressIndicator(),

        ], alignment: Alignment.center, )),padding: EdgeInsets.fromLTRB(20, 0, 20, 0),))


      ],),
    );
  }
}
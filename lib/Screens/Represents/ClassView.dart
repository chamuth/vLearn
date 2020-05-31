import 'package:elearnapp/Components/LatestActivityItem.dart';
import 'package:elearnapp/Components/LoadedClassView.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:elearnapp/Components/Shimmer/ClassViewActivityShimmer.dart';
import 'package:elearnapp/Core/Classes.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:elearnapp/Screens/Represents/Class/Assignments.dart';
import 'package:elearnapp/Screens/Tabs/Organization/PostOnTimeline.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../start.dart';
import 'Class/Questionaires.dart';
import 'ProfileView.dart';

class ClassView extends StatefulWidget {
  ClassView({Key key, this.classId}) : super(key: key);

  final String classId;

  @override
  _ClassViewState createState() => _ClassViewState();
}

class _ClassViewState extends State<ClassView> {

  ClassData data = ClassData("", "", "");
  User host = User.fromName("", "");
  bool classDataLoaded = false;
  int activitySize = -1;
  String backdropImageURL = "";

  List<ClassAction> actions;

  void loadClass() async
  {
    setState(() {
      actions = [

        ClassAction(Icons.assignment, "Assignments", 0, () { 
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => AssignmentsScreen(classData: data)),
          );
        }),
        ClassAction(Icons.query_builder, "Questionaires", 0, () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => QuestionairesScreen(classData: data)),
          );
        }),
        ClassAction(Icons.folder_shared, "Class Folder", 0, () {
          Navigator.pushReplacement(
            context, 
            CupertinoPageRoute(builder: (context) => StartScreen(startupIndex: 1, startUrl: "/" + widget.classId +"/"))
          );
        }),
        ClassAction(Icons.question_answer, "Discussion", 0, () { }),
        ClassAction(Icons.videocam, "Conference", 0, () { }),
        (User.me.teacher) ? ClassAction(Icons.share, "Invite", 0, () {
          
        })
        : ClassAction(Icons.person, "Teacher Profile", 0, () {
          Navigator.push(
            context, 
            CupertinoPageRoute(builder: (context) => ProfileView(uid: host.uid,))
          );
        }),
      ];
    });
    var classID = widget.classId;
    var temp = await ClassData.getClass(classID);
    var tempHost = await User.getUser(temp.host);

    var ref = FirebaseStorage.instance.ref().child("organizations").child(Organization.currentOrganizationId).child("class_backdrops").child(classID.toString() + ".jpg");
    try {
      var url = await ref.getDownloadURL();
      
      setState(() {
        backdropImageURL = url.toString();
      });
    }catch (e){}

    if (mounted)
    {
      setState(() {
        host = tempHost;
        data = temp;

        classDataLoaded = true;
      });
    }
  }

  @override
  void initState() {
    loadClass();
  
    super.initState();
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: MainAppBar.get(context, (data.subject == "") ? "Loading..." : data.subject + " - " + data.grade, poppable: true),
      body: Container(child: 
        ListView(children: <Widget>[
          
          LoadedClassView(actions: actions, backdropImageURL: backdropImageURL, classDataLoaded: classDataLoaded, data: data, host: host),
          
          // LATEST ACTIVITY FEED
          Padding(child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
            Seperator(title: "LATEST ACTIVITY"),
          ],), padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
          
          // LATEST ACTIVITY
          AnimatedCrossFade(duration: Duration(milliseconds: 250), crossFadeState: (activitySize != 0) ? CrossFadeState.showFirst : CrossFadeState.showSecond, firstChild: 
            Column(children: List.generate(5, (index){
              return Padding(child: Row(children: <Widget>[
                Expanded(child: 
                  AnimatedCrossFade(duration: Duration(milliseconds: 250), crossFadeState: (classDataLoaded) ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
                    firstChild: LatestActivityItem(person: User.fromName("Chamuth", "Chamandana"), actionType: ActionTypes.comment, target: "January Assignment 2020",),
                    secondChild: ClassViewActivityShimmer()
                  ),
                )
              ]), padding: EdgeInsets.fromLTRB(10, 0, 10, 0));
            })),

            secondChild: Column(children: <Widget>[
              Divider(height:25, color: Colors.transparent),
              Icon(Icons.timer_off, size: 50, color: Colors.grey),
              Divider(height:15, color: Colors.transparent),
              Text("No activity in this class", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 18))
            ],)
          )

        ],)
      ,),
    );
  }
}
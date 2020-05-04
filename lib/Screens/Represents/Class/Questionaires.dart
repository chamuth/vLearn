import 'package:elearnapp/Components/AssignmentCard.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Core/Assignment.dart';
import 'package:elearnapp/Core/Classes.dart';
import 'package:elearnapp/Questionaires/MCQ.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class QuestionairesScreen extends StatefulWidget {
  QuestionairesScreen({Key key, this.classData}) : super(key: key);

  ClassData classData;

  @override
  _QuestionairesScreenState createState() => _QuestionairesScreenState();
}

class _QuestionairesScreenState extends State<QuestionairesScreen> {

  List<Assignment> assignments = [];
  List<Assignment> submittedAssignments = [];
  bool loaded = false;

  void loadQuests() async
  {
    var quests = await Assignment.getQuestionnaires(widget.classData.id);

    if (mounted)
    {
      setState(() {
        assignments = quests;
      });
    }
    
    Future.delayed(Duration(milliseconds: 250), () 
    {
      if (mounted)
        setState(() {
          loaded = true;
        });
    });
    
  }

  @override
  void initState() {
    loadQuests();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.get(context, "Questionnaire", poppable: true),
      body: Container(child: Column(children: <Widget>[

        // Breadcrumbs
        SizedBox(child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          BreadCrumb(items: <BreadCrumbItem>[
            
            BreadCrumbItem(content: Text(widget.classData.subject + " (" + widget.classData.grade + ")", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
            BreadCrumbItem(content: Text("Questionnaire", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)))

          ], divider: Icon(Icons.keyboard_arrow_right, size: 15, color: Colors.grey),)  
        ], padding: EdgeInsets.fromLTRB(20, 5, 0, 10),), height: 32),

        Expanded(child: 
          ListView(children: <Widget>[

            if (loaded && assignments.length > 0)
              Padding(child: Row(children: <Widget>[
                Icon(Icons.list, size: 18),
                VerticalDivider(color: Colors.transparent, width: 10),
                Text("ONGOING QUESTIONNAIRES", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[200])),
                VerticalDivider(color: Colors.transparent, width: 5),
                Expanded(child: Divider()),
                VerticalDivider(color: Colors.transparent, width: 5),
                RotatedBox(quarterTurns: 1, child: Icon(Icons.chevron_right, color: Colors.grey[600], size: 20)),
              ],), padding: EdgeInsets.fromLTRB(20, 5, 20, 8)),

            AnimatedCrossFade(
              firstChild: Column(children: List.generate(assignments.length, (index) {
                return AssignmentCard(
                  dueDate: assignments[index].duedate, 
                  title: assignments[index].title, 
                  subtitle: assignments[index].subtitle, 
                  assignmentDuration: assignments[index].duration,
                  onTap: () 
                  {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => MCQScreen()),
                    );
                  }
                );
              })), secondChild: (!loaded) ? Column(children: List.generate(10, (i) {
                return  Padding(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 15, 10), child: Row(children: <Widget>[
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

                    SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.5, height: 23),
                    Divider(height:2),
                    SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.8, height: 20),
                    Divider(height:5),

                    Row(children: <Widget>[
                      SizedBox(child: Shimmer.fromColors(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.3, height: 30),
                      VerticalDivider(width: 5),
                      SizedBox(child: Shimmer.fromColors(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.30, height: 25),
                    ],)

                  ])
                ]))), padding: EdgeInsets.fromLTRB(15, 3, 15, 3));
              })) : Padding(child: Align(child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  FaIcon(FontAwesomeIcons.smile, size: 50, color: Colors.grey),
                  Divider(color: Colors.transparent, height: 10),
                  Text("Not to worry", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 17)),
                  Divider(color: Colors.transparent, height: 3),
                  Text("you don't have any questionnaires to complete", style: TextStyle(color: Colors.grey, fontSize: 15))
                ],), alignment: Alignment.center,),padding: EdgeInsets.fromLTRB(0, 50, 0, 15),
              ), duration: Duration(milliseconds: 300), crossFadeState: (assignments.length > 0) ? CrossFadeState.showFirst : CrossFadeState.showSecond),

            if (submittedAssignments.length > 0)
              Padding(child: Row(children: <Widget>[
                Icon(Icons.done, size: 18),
                VerticalDivider(color: Colors.transparent, width: 10),
                Text("SUBMITTED QUESTIONNAIRES", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[200])),
                VerticalDivider(color: Colors.transparent, width: 5),
                Expanded(child: Divider()),
                VerticalDivider(color: Colors.transparent, width: 5),
                RotatedBox(quarterTurns: 1, child: Icon(Icons.chevron_right, color: Colors.grey[600], size: 20)),
              ],), padding: EdgeInsets.fromLTRB(20, 5, 20, 8)),

          ])
        )


       ])
      )
    );
  }
}
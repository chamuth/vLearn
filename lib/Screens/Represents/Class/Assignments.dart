import 'package:elearnapp/Components/AssignmentCard.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:elearnapp/Core/Classes.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';

class AssignmentsScreen extends StatefulWidget {
  AssignmentsScreen({Key key, this.classData}) : super(key: key);

  ClassData classData;

  @override
  _AssignmentsScreenState createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.get(context, "Assignments", poppable: true),
      body: Container(child: Column(children: <Widget>[

        // Breadcrumbs
        SizedBox(child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          BreadCrumb(items: <BreadCrumbItem>[
            
            BreadCrumbItem(content: Text(widget.classData.subject + " (" + widget.classData.grade + ")", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
            BreadCrumbItem(content: Text("Assignments", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)))

          ], divider: Icon(Icons.keyboard_arrow_right, size: 15, color: Colors.grey),)  
        ], padding: EdgeInsets.fromLTRB(20, 5, 0, 10),), height: 32),

        Expanded(child: 
          ListView(children: <Widget>[
            
            Padding(child: Row(children: <Widget>[
              Text("ONGOING ASSIGNMENTS", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[200])),
              VerticalDivider(color: Colors.transparent, width: 5),
              Expanded(child: Divider()),
              VerticalDivider(color: Colors.transparent, width: 5),
              RotatedBox(quarterTurns: 1, child: Icon(Icons.chevron_right, color: Colors.grey[600], size: 20)),
            ],), padding: EdgeInsets.fromLTRB(20, 5, 20, 8)),

            Column(children: List.generate(2, (index) 
            {
              return AssignmentCard(dueDate: DateTime.now().add(Duration(hours: (index + 1) * 36 * 2)),);
            })),

            Padding(child: Row(children: <Widget>[
              Icon(Icons.done, size: 18),
              VerticalDivider(color: Colors.transparent, width: 10),
              Text("SUBMITTED ASSIGNMENTS", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[200])),
              VerticalDivider(color: Colors.transparent, width: 5),
              Expanded(child: Divider()),
              VerticalDivider(color: Colors.transparent, width: 5),
              RotatedBox(quarterTurns: 1, child: Icon(Icons.chevron_right, color: Colors.grey[600], size: 20)),
            ],), padding: EdgeInsets.fromLTRB(20, 15, 20, 8)),

            Column(children: List.generate(5, (index) 
            {
              return IgnorePointer(child: Opacity(child: AssignmentCard(dueDate: DateTime.now().add(Duration(hours: 400)),), opacity:0.5), ignoring: true);
            })),

          ],)
        )

      ],)
      ,),
    );
  }
}
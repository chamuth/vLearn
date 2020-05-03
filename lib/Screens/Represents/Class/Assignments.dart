import 'package:elearnapp/Components/AssignmentCard.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Core/Classes.dart';
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

            Column(children: List.generate(2, (index) 
            {
              return AssignmentCard();
            }))

          ],)
        )

      ],)
      ,),
    );
  }
}
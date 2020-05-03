import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssignmentCard extends StatefulWidget {
  AssignmentCard({Key key}) : super(key: key);

  @override
  _AssignmentCardState createState() => _AssignmentCardState();
}

class _AssignmentCardState extends State<AssignmentCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: RawMaterialButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Padding(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

        Container(width: 5, height: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.green),),

        VerticalDivider(color: Colors.transparent, width:12),

        Expanded(child: 
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text("Computer Science 101 - Assignment 01", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.green,)),
            Divider(color: Colors.transparent, height: 5),
            Text("Data Structures and Algorithms", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[100],)),
            Divider(color: Colors.transparent, height: 5),
            Row(children: <Widget>[
              Icon(Icons.calendar_today, size: 13, color: Colors.grey),
              VerticalDivider(color: Colors.transparent, width: 5),
              Text("Due date: 20/01/2020", style: TextStyle(fontSize: 14, color: Colors.grey,)),
              VerticalDivider(),
              Icon(Icons.timer, size: 15, color: Colors.grey),
              VerticalDivider(color: Colors.transparent, width: 5),
              Text("10 minutes", style: TextStyle(fontSize: 14, color: Colors.grey,)),
            ],),
            Divider(color: Colors.transparent, height: 2),

            Row(children: <Widget>[
              Chip(label: Row(children: <Widget>[
                Icon(Icons.info_outline, size: 15),
                VerticalDivider(color: Colors.transparent, width: 5),
                Text("10 days remaining", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
              ],), backgroundColor: Colors.green,),
              VerticalDivider(color: Colors.transparent, width: 15),
              Icon(Icons.open_in_new, size: 15, color: Colors.grey[300]),
              VerticalDivider(color: Colors.transparent, width: 5,),
              Text("Tap to open", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[300]))
            ],)

          ],)
        ),



      ],), padding: EdgeInsets.fromLTRB(10, 10, 15, 7),), clipBehavior: Clip.antiAlias,), onPressed: () { },), 
      padding: EdgeInsets.fromLTRB(15, 3, 15, 3)
    );
  }
}
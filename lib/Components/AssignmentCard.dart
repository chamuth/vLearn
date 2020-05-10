import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssignmentCard extends StatefulWidget {
  AssignmentCard({Key key, this.onTap, this.title, this.subtitle, this.dueDate, this.assignmentDuration}) : super(key: key);

  String title;
  String subtitle;
  DateTime dueDate;
  Duration assignmentDuration;
  Function onTap;

  @override
  _AssignmentCardState createState() => _AssignmentCardState();
}

class _AssignmentCardState extends State<AssignmentCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: RawMaterialButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Padding(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

        Container(width: 5, height: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: timeRemaining(widget.dueDate).statusColor),),

        VerticalDivider(color: Colors.transparent, width:12),

        Expanded(child: 
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(widget.title ?? "Computer Science 101 - Assignment 01", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: timeRemaining(widget.dueDate).statusColor,)),
            Divider(color: Colors.transparent, height: 5),
            Text(widget.subtitle ?? "Data Structures and Algorithms", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[100],)),
            Divider(color: Colors.transparent, height: 5),
            Row(children: <Widget>[
              Icon(Icons.calendar_today, size: 13, color: Colors.grey),
              VerticalDivider(color: Colors.transparent, width: 5),
              Text("Due date: " + (new DateFormat('dd/MM/yyyy')).format(widget.dueDate ?? DateTime.now()), style: TextStyle(fontSize: 14, color: Colors.grey,)),
              VerticalDivider(),
              Icon(Icons.timer, size: 15, color: Colors.grey),
              VerticalDivider(color: Colors.transparent, width: 5),
              Text((widget.assignmentDuration ?? Duration(minutes: 15)).inMinutes.toString() + " minutes", style: TextStyle(fontSize: 14, color: Colors.grey,)),
            ],),
            Divider(color: Colors.transparent, height: 2),

            Row(children: <Widget>[
              Chip(label: Row(children: <Widget>[
                Icon(Icons.info_outline, size: 15),
                VerticalDivider(color: Colors.transparent, width: 5),
                Text(timeRemaining(widget.dueDate).remainingText, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
              ],), backgroundColor: timeRemaining(widget.dueDate).statusColor,),
              VerticalDivider(color: Colors.transparent, width: 15),
              Icon(Icons.open_in_new, size: 15, color: Colors.grey[300]),
              VerticalDivider(color: Colors.transparent, width: 5,),
              Text("Tap to open", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[300]))
            ],)

          ],)
        ),



      ],), padding: EdgeInsets.fromLTRB(10, 10, 15, 5),), clipBehavior: Clip.antiAlias,), onPressed: () {
        widget.onTap();
      },), 
      padding: EdgeInsets.fromLTRB(15, 3, 15, 3)
    );
  }

  RemainingStatus timeRemaining(DateTime dueDate) {
    var duration = dueDate.difference(DateTime.now());

    if (duration.inDays > 0)
    {
      // There are more than days
      if (duration.inDays > 5)
      {
        return RemainingStatus(duration.inDays.toString() + " days remaining", Colors.green);
      }
      else 
      {
        return RemainingStatus(duration.inDays.toString() + " days remaining", Colors.red);
      }
    } else if (duration.inHours > 0) {
      return RemainingStatus(duration.inHours.toString() + " hours remaining", Colors.red);
    } else if (duration.inMinutes > 0)
    {
      return RemainingStatus(duration.inMinutes.toString() + " minutes remaining", Colors.red);
    } else if (duration.inSeconds > 0)
    {
      return RemainingStatus(duration.inSeconds.toString() + " seconds remaining", Colors.red);
    }

    if (!dueDate.isAfter(DateTime.now()))
    {
      return RemainingStatus("Due date lapsed", Colors.red);
    }
  }
}

class RemainingStatus
{
  String remainingText;
  Color statusColor;

  RemainingStatus(this.remainingText, this.statusColor);
}
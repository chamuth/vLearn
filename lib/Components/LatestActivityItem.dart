import 'package:elearnapp/Core/User.dart';
import 'package:flutter/material.dart';

enum ActionTypes 
{
  comment, mention, message
}

class LatestActivityItem extends StatefulWidget {
  LatestActivityItem({Key key, this.person, this.actionType, this.target, this.onTap}) : super(key: key);

  User person;
  ActionTypes actionType;
  String target;
  Function onTap;

  @override
  LatestActivityItemState createState() => LatestActivityItemState();
}

class LatestActivityItemState extends State<LatestActivityItem> {
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      child: Row(children: <Widget>[
        CircleAvatar(radius: 18, child: Text(widget.person.firstName.substring(0,1), style: TextStyle(color: Colors.white)), backgroundColor: Theme.of(context).primaryColor,),
        VerticalDivider(),
        Expanded(child: 
          Wrap(runSpacing: 4, direction: Axis.horizontal, children: <Widget>[
            Text(widget.person.firstName + " " + widget.person.lastName, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(" commented on ", style: TextStyle(color: Colors.grey[400])),
            Text(widget.target, style: TextStyle(fontWeight: FontWeight.bold)),
          ],) 
        ),
        Icon(Icons.comment),
        VerticalDivider(width:10),
      ],), 
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
    ));
  }
}
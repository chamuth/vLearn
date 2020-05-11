import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearnapp/Core/Ellipsis.dart';
import 'package:elearnapp/Core/Events.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class EventCard extends StatefulWidget {
  EventCard({Key key, this.type, this.event}) : super(key: key);

  EventType type;
  Event event;

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> 
{
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Card(
        child: Column(children: <Widget>[
          Padding(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              
              Row(children: <Widget>[
                Expanded(child: Text(widget.event.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                Text(timeago.format(widget.event.created), style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 12))
              ],),

              Divider(color: Colors.transparent, height: 2),
              Text(ellipsis(widget.event.description, 100), textAlign: TextAlign.start, style: TextStyle(color: Colors.grey[400])),
              Divider(color: Colors.transparent, height: 3),

            ],), padding: EdgeInsets.fromLTRB(10, 7, 10, 7),
          ),         

          GridView.count(physics: NeverScrollableScrollPhysics(), crossAxisCount: 3, shrinkWrap: true, crossAxisSpacing: 0, mainAxisSpacing: 0, children: List.generate(6, (index)
          {
            if (10 > 6 && index == 5)
            {
              return Stack(fit: StackFit.expand, children: <Widget>[
                Image(fit: BoxFit.fitHeight, image: AssetImage("assets/images/83585711_119296336285671_5760048956415410176_n.jpg")),
                Container(color: Colors.grey[900].withOpacity(0.65)),
                Align(child: Text("+35", style: TextStyle(fontSize: 30), textAlign: TextAlign.center,), alignment: Alignment.center,)
              ],);
            } else {
              return Image(fit: BoxFit.fitHeight, image: AssetImage("assets/images/83585711_119296336285671_5760048956415410176_n.jpg"));
            }
          }),)

        ],),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
      ), 
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
    );
  }
}
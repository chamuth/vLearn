import 'package:elearnapp/Core/Classes.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class TimetableItem extends StatefulWidget {
  TimetableItem({Key key, this.themeColor, this.eventAvailable, this.timeframe}) : super(key: key);

  Color themeColor = Colors.blue[400];
  bool eventAvailable;
  DateTime timeframe;

  @override
  _TimetableItemState createState() => _TimetableItemState();
}

class _TimetableItemState extends State<TimetableItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: (widget.eventAvailable ? 65 : 40), child: Row(children: <Widget>[
      SizedBox(
        width:60,  
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[ 
          Expanded(child: Align(child: Text(" " + (widget.timeframe.hour).toString().padLeft(2, "0") + ":" + widget.timeframe.minute.toString().padLeft(2, "0"), 
            textAlign: TextAlign.start,
            style: TextStyle(color: (widget.eventAvailable) ? widget.themeColor : Colors.grey, fontWeight : FontWeight.bold)
          ), alignment: Alignment.centerLeft,),),
        ]),
      ),

      if (!widget.eventAvailable)
        Expanded(child: Container(color: Colors.grey[900])),
      if (widget.eventAvailable)
        Expanded(child: Padding(child: Container(
          child: Row(children: <Widget>[
            
            SizedBox(width: 8, child: Container(color: widget.themeColor)),

            Expanded(child: Container(child: Padding(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              
              Text("Physics Livestream", style: TextStyle(fontWeight: FontWeight.bold, color: widget.themeColor, fontSize: 16)),
              Divider(color: Colors.transparent, height: 2),
              Text("Hosted by " + Faker().person.name()),
              Divider(color: Colors.transparent, height: 1),
              Text(widget.timeframe.hour.toString().padLeft(2, "0") + ":" + widget.timeframe.minute.toString().padLeft(2, "0") + 
              " - " + widget.timeframe.add(Duration(minutes:30)).hour.toString().padLeft(2, "0") + ":" + widget.timeframe.add(Duration(minutes:30)).minute.toString().padLeft(2, "0"), style: TextStyle(fontSize: 13, color: Colors.grey)),

            ],), padding: EdgeInsets.fromLTRB(10, 8, 10, 8),),),),      
            
          ]
        ,)), padding: EdgeInsets.fromLTRB(0, 0, 0, 2),),)

    ],));
  }
}
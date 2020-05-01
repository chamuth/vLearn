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

  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(firstChild: SizedBox(height: (widget.eventAvailable ? 65 : 40), child: Row(children: <Widget>[
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
        Expanded(child: RawMaterialButton(child: Padding(child: Container(
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
        ,)), padding: EdgeInsets.fromLTRB(0, 0, 0, 2),), onPressed: () { 
          setState(() {
            expanded = true;
          });

          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              expanded = false;
            });
          });
        },),)

    ],)),
    duration: Duration(milliseconds: 350),
    secondChild: SizedBox(height: 100, child: Container(color: widget.themeColor, child: Padding(child: Container(child: Row(children: <Widget>[
      
      Expanded(
        child: RawMaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: <Widget>[
            Icon(Icons.open_in_new,),
            Divider(color: Colors.transparent, height: 8),
            Text("Open Class")
          ],),
          onPressed: () { },
        )
      ),

      Expanded(
        child: RawMaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: <Widget>[
            Icon(Icons.question_answer,),
            Divider(color: Colors.transparent, height: 8),
            Text("Message Teacher")
          ],),
          onPressed: () { },
        )
      ),

      Expanded(
        child: RawMaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: <Widget>[
            Icon(Icons.folder_shared,),
            Divider(color: Colors.transparent, height: 8),
            Text("Shared Folder")
          ],),
          onPressed: () { },
        )
      ),

    ],)), padding: EdgeInsets.fromLTRB(10, 5, 10, 5),)
    ,)),
    crossFadeState: (!expanded) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
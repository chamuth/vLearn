import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/material.dart';

class ClassItem extends StatefulWidget {
  ClassItem({Key key, this.subject, this.grade, this.hostName}) : super(key: key);

  String subject;
  String grade;
  String hostName;

  @override
  _ClassItemState createState() => _ClassItemState();
}

class _ClassItemState extends State<ClassItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(child: Row(children: <Widget>[
        
        Icon(Icons.class_, size: 30, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor),
         
        Expanded(child: Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0), child: 
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(widget.subject, style: TextStyle(color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor, fontSize: 17, fontWeight: FontWeight.bold)),
            Padding(child: Text(widget.grade, style: TextStyle(color: Colors.grey)), padding: EdgeInsets.fromLTRB(0, 2, 0, 0))
          ],))
        ),
        
        Padding(padding: EdgeInsets.fromLTRB(0, 0, 2, 0), child: 
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
            Padding(child: Text("Hosted by", style: TextStyle(color: Colors.grey)), padding: EdgeInsets.fromLTRB(0, 0, 0, 2)),
            Text(widget.hostName, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ],)
        ),

      ],), padding:EdgeInsets.all(10))
    );
  }
}
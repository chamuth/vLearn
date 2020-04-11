import 'package:flutter/material.dart';

class Seperator extends StatefulWidget {
  Seperator({Key key, this.title}) : super(key: key);
  String title;
  @override
  _SeperatorState createState() => _SeperatorState();
}

class _SeperatorState extends State<Seperator> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding:EdgeInsets.fromLTRB(10, 15, 10, 15), child: Row(children: <Widget>[
      Expanded(child: Divider()),
      Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0), child: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
      Expanded(child: Divider()),
    ],));
  }
}
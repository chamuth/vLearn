import 'package:flutter/material.dart';

class MCQAnswerItem extends StatefulWidget {
  MCQAnswerItem({Key key, this.answer}) : super(key: key);

  String answer = "";

  @override
  _MCQAnswerItemState createState() => _MCQAnswerItemState();
}

class _MCQAnswerItemState extends State<MCQAnswerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        Expanded(child: OutlineButton(onPressed: () { }, child: Text(widget.answer, textAlign: TextAlign.start,)),)
      ],)
    );
  }
}
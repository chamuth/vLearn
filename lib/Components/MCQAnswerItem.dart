import 'package:flutter/material.dart';

class MCQAnswerItem extends StatefulWidget {
  MCQAnswerItem({Key key, this.answer, this.selected, this.onPressed }) : super(key: key);

  String answer = "";
  bool selected = false;
  Function onPressed;

  @override
  _MCQAnswerItemState createState() => _MCQAnswerItemState();
}

class _MCQAnswerItemState extends State<MCQAnswerItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        Expanded(child: OutlineButton(borderSide: BorderSide(color: (widget.selected) ? Theme.of(context).primaryColor : Colors.grey), onPressed: () { widget.onPressed(); }, child: Text(widget.answer, textAlign: TextAlign.start,)),)
      ],)
    );
  }
}
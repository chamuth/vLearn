import 'package:flutter/material.dart';

class AllQuestionsDisplayItem extends StatefulWidget {
  AllQuestionsDisplayItem({Key key, this.index, this.answered}) : super(key: key);

  int index = 0;
  bool answered = false;

  @override
  _AllQuestionsDisplayItemState createState() => _AllQuestionsDisplayItemState();
}

class _AllQuestionsDisplayItemState extends State<AllQuestionsDisplayItem> {
  @override
  Widget build(BuildContext context) {
    return  Container(padding: EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(10)), color: (widget.answered) ? Theme.of(context).accentColor : Colors.red,),
        child: Center(
          child: Text(
            (widget.index + 1).toString(),
          ),
        )
      )
    );
  }
}
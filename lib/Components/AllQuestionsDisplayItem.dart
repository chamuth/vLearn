import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class AllQuestionsDisplayItem extends StatefulWidget {
  AllQuestionsDisplayItem({Key key, this.index, this.answered, this.onTap}) : super(key: key);

  int index = 0;
  bool answered = false;
  Function onTap;

  @override
  _AllQuestionsDisplayItemState createState() => _AllQuestionsDisplayItemState();
}

class _AllQuestionsDisplayItemState extends State<AllQuestionsDisplayItem> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(onPressed: () { widget.onTap(widget.index); },
      child: Container(padding: EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(10)), color: (widget.answered) ? Theme.of(context).accentColor : Colors.red,),
          child: Center(
            child: Text(
              (widget.index + 1).toString(),
            ),
          )
        )
      )
    );
  }
}
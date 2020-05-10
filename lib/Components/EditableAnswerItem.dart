import 'package:flutter/material.dart';

class EditableAnswerItem extends StatefulWidget {
  EditableAnswerItem({Key key, this.editable, this.text, this.index, this.remove, this.updateText, this.correct, this.setCorrect}) : super(key: key);

  bool editable = false;
  String text = "";
  int index = 0;
  Function remove;
  Function updateText;
  Function setCorrect;
  bool correct;

  @override
  _EditableAnswerItemState createState() => _EditableAnswerItemState();
}

class _EditableAnswerItemState extends State<EditableAnswerItem> {

  var textController = new TextEditingController();

  void changeText(str)
  {
    widget.updateText(str);
  }

  @override
  Widget build(BuildContext context) {

    if (!widget.editable)
    {
      textController.text = widget.text;
    }

    return Row(children: <Widget>[
      Expanded(child: Stack(children: <Widget>[
        TextField(
          controller: textController,
          onChanged: changeText,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always, 
            labelText: 'Answer #' + (widget.index + 1).toString(),
            contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0),
            alignLabelWithHint: true,
            labelStyle: TextStyle(fontSize: 20, color: Colors.grey[300]),
            suffixIcon: AnimatedOpacity(child: Padding(child: Icon(Icons.done, color: Colors.green, size: 20), padding: EdgeInsets.fromLTRB(15,10,0,0)), opacity:0, duration: Duration(milliseconds: 100)),
          )
        ),
        AnimatedOpacity(child: Padding(child: Text("Eg:- Data Structures Test 1", style: TextStyle(color: Colors.grey[600])), padding: EdgeInsets.fromLTRB(0, 26, 0, 0),), duration: Duration(milliseconds: 100), opacity: (textController.text == "") ? 1 : 0),
      ],),),

      VerticalDivider(width: 10),
      
      Padding(child: IconButton(tooltip: "Set as correct answer", icon: Icon(Icons.done, color: (widget.correct) ? Colors.green : Colors.grey), onPressed: () { if (widget.setCorrect != null) widget.setCorrect(); }, ), padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
      Padding(child: IconButton(tooltip: "Remove answer", icon: Icon(Icons.close, color: Colors.red), onPressed: () { if (widget.remove != null) widget.remove(); }, ), padding: EdgeInsets.fromLTRB(0, 5, 0, 0))

    ]);
  }
}
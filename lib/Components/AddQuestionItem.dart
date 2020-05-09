import 'dart:math';

import 'package:elearnapp/Questionaires/MCQ.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'EditableAnswerItem.dart';

class AddQuestionItem extends StatefulWidget {
  AddQuestionItem({Key key, this.index, this.question}) : super(key: key);

  int index;
  Question question;

  @override
  _AddQuestionItemState createState() => _AddQuestionItemState();
}

class _AddQuestionItemState extends State<AddQuestionItem> {

  bool open = false;
  bool editable = false;
  final TextEditingController questionTitleController = new TextEditingController();
  List<String> answers = [];

  @override
  Widget build(BuildContext context) {
    if (!open)
    {
      questionTitleController.text = widget.question.question;
      answers = widget.question.answers;
    }

    return Padding(child: GestureDetector(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Padding(child: 
      AnimatedCrossFade(firstChild: 
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Icon(Icons.live_help, size: 18, color: Colors.grey[200]),
            VerticalDivider(width: 12),

            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text("Question #" + (widget.index + 1).toString(), style: TextStyle(color: Colors.grey[400], fontSize: 16, fontWeight: FontWeight.bold)),
              Text(widget.question.question, style: TextStyle(color: Colors.grey[200], fontSize: 20, fontWeight: FontWeight.bold)),
            ],))
          ]),

          Divider(height: 15, color: Colors.transparent),
          Align(child: 
            Row(children: <Widget>[
              Icon(Icons.edit, size: 16, color: Colors.grey),
              VerticalDivider(color: Colors.transparent, width: 10),
              Text("Tap to edit question", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ],),
            alignment: Alignment.center,
          )

        ]),
        secondChild: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Icon(Icons.edit, size: 18, color: Colors.grey[200]),
            VerticalDivider(width: 12),

            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text("Editing Question #" + (widget.index + 1).toString(), style: TextStyle(color: Colors.grey[400], fontSize: 16, fontWeight: FontWeight.bold)),
            ],))
          ]),

          Divider(color: Colors.transparent, height: 10),

          Stack(children: <Widget>[
            TextField(
              controller: questionTitleController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always, 
                labelText: 'Question Title',
                contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                alignLabelWithHint: true,
                labelStyle: TextStyle(fontSize: 20, color: Colors.grey[300]),
                suffixIcon: AnimatedOpacity(child: Padding(child: Icon(Icons.done, color: Colors.green, size: 20), padding: EdgeInsets.fromLTRB(15,10,0,0)), opacity:0, duration: Duration(milliseconds: 100)),
              )
            ),
            AnimatedOpacity(child: Padding(child: Text("Eg:- Data Structures Test 1", style: TextStyle(color: Colors.grey[600])), padding: EdgeInsets.fromLTRB(0, 26, 0, 0),), duration: Duration(milliseconds: 100), opacity: (questionTitleController.text == "") ? 1 : 0),
          ],),

          Divider(color: Colors.transparent, height: 10),

          Text("Answers", style: TextStyle(fontSize: 15, color: Colors.grey[300])),

          Row(children: <Widget>[
            Expanded(child: OutlineButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Icon(Icons.add),
              VerticalDivider(width: 5),
              Text("Add Answer")
            ],), onPressed: () {
              answers.add("");
            },)),
            VerticalDivider(width: 10),
            Expanded(child: OutlineButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              FaIcon(FontAwesomeIcons.random, size: 15),
              VerticalDivider(width: 10),
              Text("Randomize")
            ],), onPressed: () {
              setState(() {
                editable = false;
                answers.shuffle();
                print(answers);
              });

              Future.delayed(Duration(milliseconds: 200), () {
                if (mounted)
                  setState(() {
                    editable = true;
                  });
              });

            },)),
          ],),

          Column(children: List.generate(answers.length, (i) {
            return EditableAnswerItem(text: answers[i], editable: editable, index: i, remove: () {
              // remove the item at that location
              answers.removeAt(i);
            }, updateText: (str) {
              
              setState(() {
                answers[i] = str;
              });

            },);
          })),

          Divider(color: Colors.transparent, height: 15),

          Row(children: <Widget>[
            Expanded(child: RaisedButton(child: Text("Cancel"), color:Colors.grey[700], onPressed: () {},),),
            VerticalDivider(width: 10),
            Expanded(child: RaisedButton(child: Text("Save"), color: Theme.of(context).primaryColor, onPressed: () {},)),
          ],)

        ]),
        crossFadeState: (open) ? CrossFadeState.showSecond : CrossFadeState.showFirst, duration: Duration(milliseconds: 250),
      ),
    padding: EdgeInsets.fromLTRB(18, 13, 18, 13),),), onTap: () { 
      if (!open)
        setState(() {
          open = true;
          editable = true;
        });
    },), padding: EdgeInsets.fromLTRB(15, 5, 15, 5));
  }
}

List shuffle(List items) {
  var random = new Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {

    // Pick a pseudorandom number according to the list length
    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}
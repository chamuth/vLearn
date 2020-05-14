import 'dart:math';

import 'package:elearnapp/Core/Questionnaire.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import 'EditableAnswerItem.dart';

class AddQuestionItem extends StatefulWidget {
  AddQuestionItem({Key key, this.index, this.question, this.saveQuestion, this.correctAnswer, this.changeOrder, this.deleteQuestion}) : super(key: key);

  int index;
  Question question;
  Function saveQuestion;
  int correctAnswer;
  Function changeOrder;
  Function deleteQuestion;

  @override
  _AddQuestionItemState createState() => _AddQuestionItemState();
}

class _AddQuestionItemState extends State<AddQuestionItem> {

  bool open = false;
  bool editable = false;
  final TextEditingController questionTitleController = new TextEditingController();
  List<String> answers = [];
  int correctAnswer = -1;

  @override
  Widget build(BuildContext context) {
    if (!open)
    {
      questionTitleController.text = widget.question.question;
      answers = widget.question.answers;
      correctAnswer = widget.correctAnswer ?? -1;
    }

    return Padding(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Padding(child: 
      AnimatedCrossFade(firstChild: 
        GestureDetector(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Icon(Icons.live_help, size: 18, color: Colors.grey[200]),
            VerticalDivider(width: 12),

            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Row(children: <Widget>[
                Expanded(child: Text("Question #" + (widget.index + 1).toString(), style: TextStyle(color: Colors.grey[400], fontSize: 16, fontWeight: FontWeight.bold)),),
                // Transform.scale(child: OutlineButton(visualDensity: VisualDensity.compact, child: Text("Up"), onPressed: () { },), scale: 0.9,),
                TouchableOpacity(child: Icon(Icons.arrow_upward, size: 20), onTap: () { widget.changeOrder(false); },),
                VerticalDivider(width: 10),
                TouchableOpacity(child: Icon(Icons.arrow_downward, size: 20), onTap: () { widget.changeOrder(true); },),
                VerticalDivider(width: 15),
                TouchableOpacity(child: Icon(Icons.close, color: Colors.red, size: 20), onTap: () { 
                  widget.deleteQuestion(); 
                },),
              ],),
              Divider(height: 5, color: Colors.transparent),
              Text((widget.question.question != "") ? widget.question.question : "[Question not provided]", style: TextStyle(color: Colors.grey[200], fontSize: 20, fontWeight: FontWeight.bold)),
              Divider(height: 10, color: Colors.transparent),
              Text("Answer: " + ((correctAnswer == -1) ? "Not selected yet" : answers[correctAnswer]), style: TextStyle(color: Colors.grey[400], fontSize: 16, fontWeight: FontWeight.bold)),
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

        ]), onTap: () { 
          if (!open)
            setState(() {
              open = true;
              editable = true;
            });
        },),
        secondChild: IgnorePointer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

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
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always, 
                labelText: 'Question Title',
                contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                alignLabelWithHint: true,
                labelStyle: TextStyle(fontSize: 20, color: Colors.grey[300]),
                suffixIcon: AnimatedOpacity(child: Padding(child: Icon(Icons.done, color: Colors.green, size: 20), padding: EdgeInsets.fromLTRB(15,10,0,0)), opacity:0, duration: Duration(milliseconds: 100)),
              )
            ),
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
            return EditableAnswerItem(text: answers[i], editable: editable, correct: (i == correctAnswer), index: i, remove: () {
              // remove the item at that location
              if (answers.length != 1) // if there are at least one answer
                answers.removeAt(i);

            }, updateText: (str) {
              
              setState(() {
                answers[i] = str;
              });

            }, setCorrect: () {
              correctAnswer = i;
            },);
          })),

          Divider(color: Colors.transparent, height: 15),

          Row(children: <Widget>[
            Expanded(child: RaisedButton(child: Text("Cancel"), color:Colors.grey[700], onPressed: () {
              setState(() {
                open = false;
              });
            },),),
            VerticalDivider(width: 10),
            Expanded(child: RaisedButton(child: Text("Save"), color: Theme.of(context).primaryColor, onPressed: () {
              if(widget.saveQuestion != null)
                widget.saveQuestion({
                  "correct" : correctAnswer,
                  "question" : Question(question: questionTitleController.text, answers: answers)
                });
              
              setState(() {
                open = false;
              });
            },)),
          ],)

        ]), ignoring: (!open)),
        crossFadeState: (open) ? CrossFadeState.showSecond : CrossFadeState.showFirst, duration: Duration(milliseconds: 250),
      ),
    padding: EdgeInsets.fromLTRB(18, 13, 18, 13),),), padding: EdgeInsets.fromLTRB(15, 5, 15, 5));
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
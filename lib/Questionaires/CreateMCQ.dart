import 'package:elearnapp/Core/AlertDialog.dart';
import 'package:elearnapp/Core/Classes.dart';
import 'package:elearnapp/Core/Questionnaire.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:humanize/humanize.dart' as humanize;

import 'package:elearnapp/Components/AddQuestionItem.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CreateMCQScreen extends StatefulWidget {
  CreateMCQScreen({Key key, this.classInfo}) : super(key: key);

  ClassData classInfo;

  @override
  _CreateMCQScreenState createState() => _CreateMCQScreenState();
}

class _CreateMCQScreenState extends State<CreateMCQScreen> {
  
  bool publishNow = true;
  bool randomizeQuestions = false;
  bool randomizeAnswers = false;

  final TextEditingController titleController = new TextEditingController();
  final TextEditingController subtitleController = new TextEditingController();
  final TextEditingController durationController = new TextEditingController();
  DateTime selectedPublishDateTime;
  DateTime dueDateDateTime;

  List<Question> questions = [];

  List<int> correctAnswers = [];
  
  @override
  void initState() {
    super.initState();
  }

  void selectPublishDate() async
  {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: (selectedPublishDateTime ?? DateTime.now()),
      firstDate: DateTime.now(), // dates starting from now
      lastDate: DateTime.now().add(Duration(days: 365)), // dates advancing to a year
    );

    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: selectedPublishDateTime ?? TimeOfDay.now()
    );

    setState(() {
      if (date != null && time != null)
        selectedPublishDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  void submitQuestionnaire()
  {
    bool valid = true;
    String message;

    // title is required
    if (titleController.text.trim() == "")
    {
      valid = false;
      message = "Please enter a title for the questionnaire";
    }
    // subtitle is optional

    // there should at least be one question
    if (questions.length == 0)
      valid = false;

    for(var i = 0; i < questions.length; i ++)
    {
      var q = questions[i];

      if (q.question.trim() != "")
      {
        valid = false;
        message = "Question #" + (i + 1).toString() + " not provided";
        break;
      }

      if (q.answers.length == 0)
      {
        valid = false;
        message = "No answers provided for question #" + (i + 1).toString();
        break;
      }

      if (correctAnswers[i] == -1)
      {
        valid = false;
        message = "No correct answer selected for question #" + (i + 1).toString();
        break;
      }
    }

    if (!valid)
    {
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message, style:TextStyle(color: Colors.white)), backgroundColor: Colors.red,));
    }
    else 
    {
      
    }

  }
  
  void addQuestion()
  {
    setState(() {
      questions.add(Question(question: "", answers: [""]));
      correctAnswers.add(-1);
    });
  }

  Future<bool> _onWillPop() {
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed:  () { 
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);
      },
    );
    Widget noButton = FlatButton(
      child: Text("No"),
      onPressed:  () {  
        Navigator.of(context).pop(); 
      },
    );
    
    
    showAlertDialog(context, "Exiting", " The questionnaire will not be published if you exit, are you sure you want to discard the changes?", [yesButton, noButton] );
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onWillPop, child: Scaffold(
      key: scaffoldKey,
      appBar: MainAppBar.get(context, "Create New Questionnaire", poppable: true, done: submitQuestionnaire),
      body: Container(color: Colors.grey[900], child: Stack(children: <Widget>[ 
        ListView(children: <Widget>[
          // BASIC INFORMATION CARD
          Padding(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Padding(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Row(children: <Widget>[
              Icon(Icons.view_list, size: 20, color: Colors.grey[200]),
              VerticalDivider(width: 12),
              Text("Basic Information", style: TextStyle(color: Colors.grey[200], fontSize: 22, fontWeight: FontWeight.bold)),
            ]),

            Divider(color: Colors.transparent, height: 12),

            Text("Questionaire for ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey[300])),
            Divider(color: Colors.transparent, height: 1),
            Text(widget.classInfo.subject + "(" + widget.classInfo.grade + ")", style: TextStyle(fontSize: 15, color: Colors.grey[300])),
            
            Divider(color: Colors.transparent, height: 5),

            Stack(children: <Widget>[
              TextField(
                controller: titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always, 
                  labelText: 'Questionnaire Title',
                  contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                  labelStyle: TextStyle(fontSize: 20, color: Colors.grey[300]),
                  alignLabelWithHint: true,
                  suffixIcon: AnimatedOpacity(child: Padding(child: Icon(Icons.done, color: Colors.green, size: 20), padding: EdgeInsets.fromLTRB(15,10,0,0)), opacity:0, duration: Duration(milliseconds: 100)),
                  helperText: "Title of the unit, lesson, or major heading"
                )
              ),
              AnimatedOpacity(child: Padding(child: Text("Eg:- Computer Engineering 101", style: TextStyle(color: Colors.grey[600])), padding: EdgeInsets.fromLTRB(0, 26, 0, 0),), duration: Duration(milliseconds: 100), opacity: (titleController.text == "") ? 1 : 0),
            ],),

            Divider(color: Colors.transparent, height: 5),

            Stack(children: <Widget>[
              TextField(
                controller: subtitleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always, 
                  labelText: 'Questionnaire Subtitle',
                  contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(fontSize: 20, color: Colors.grey[300]),
                  suffixIcon: AnimatedOpacity(child: Padding(child: Icon(Icons.done, color: Colors.green, size: 20), padding: EdgeInsets.fromLTRB(15,10,0,0)), opacity:0, duration: Duration(milliseconds: 100)),
                  helperText: "Name of the test with number or sub-heading"
                )
              ),
              AnimatedOpacity(child: Padding(child: Text("Eg:- Data Structures Test 1", style: TextStyle(color: Colors.grey[600])), padding: EdgeInsets.fromLTRB(0, 26, 0, 0),), duration: Duration(milliseconds: 100), opacity: (subtitleController.text == "") ? 1 : 0),
            ],),

            Divider(color: Colors.transparent, height: 5),

            Stack(children: <Widget>[
              TextField(
                controller: durationController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always, 
                  labelText: 'Questionnaire Duration',
                  suffix: Text("Minutes"),
                  contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(fontSize: 20, color: Colors.grey[300]),
                  suffixIcon: AnimatedOpacity(child: Padding(child: Icon(Icons.done, color: Colors.green, size: 20), padding: EdgeInsets.fromLTRB(15,10,0,0)), opacity:0, duration: Duration(milliseconds: 100)),
                  helperText: "The duration for the questionnaire in minutes"
                ),
                keyboardType: TextInputType.number,
              ),
              AnimatedOpacity(child: Padding(child: Text("Eg:- 30", style: TextStyle(color: Colors.grey[600])), padding: EdgeInsets.fromLTRB(0, 26, 0, 0),), duration: Duration(milliseconds: 100), opacity: (durationController.text == "") ? 1 : 0),
            ],),

            Divider(height: 25),

            Text("Questionnaire Settings", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey[300])),
            Divider(color: Colors.transparent, height: 5),

            RawMaterialButton(child: 
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

                Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  SizedBox(child: Checkbox(
                    value: publishNow,
                    onChanged: (v) { publishNow = !publishNow; },
                    activeColor: Theme.of(context).primaryColor,
                    visualDensity: VisualDensity.compact,
                  ), width: 20, height: 20),

                  VerticalDivider(width: 10),

                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    Text("Publish Now", style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("You can publish this questionnaire to your students now or you can set a date and time for this questionnaire to be released", style: TextStyle(color: Colors.grey)),
                  ],))

                ],),

              ],),
              onPressed: () { publishNow = !publishNow; },
              padding: EdgeInsets.fromLTRB(5, 10, 5, 10)
            ),

            AnimatedCrossFade(crossFadeState: (!publishNow) ? CrossFadeState.showFirst : CrossFadeState.showSecond, firstChild: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text("Publish Date and Time", style: TextStyle(fontSize: 15, color: Colors.grey[300])),
              Divider(color: Colors.transparent, height: 5),
              
              RawMaterialButton(child: Row(children: <Widget>[
                  Expanded(child: Text((new DateFormat('HH:mm of dd/MM/yyyy')).format(selectedPublishDateTime ?? DateTime.now()), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[300]))),
                  Text("Tap to set date", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold))
                ],),
                onPressed: () {
                  selectPublishDate();
                },
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),

              Divider(color: Colors.transparent, height: 10),

            ],), secondChild: Container(), duration: Duration(milliseconds: 200)),

            RawMaterialButton(child: 
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

                Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  SizedBox(child: Checkbox(
                    value: randomizeQuestions,
                    onChanged: (v) { randomizeQuestions = !randomizeQuestions; },
                    activeColor: Theme.of(context).primaryColor,
                    visualDensity: VisualDensity.compact,
                  ), width: 20, height: 20),

                  VerticalDivider(width: 10),

                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    Text("Randomize Questions", style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("When enabled, each student will receive questions in a random order making it hard to cheat.", style: TextStyle(color: Colors.grey)),
                  ],))

                ],),

              ],),
              onPressed: () { randomizeQuestions = !randomizeQuestions; },
              padding: EdgeInsets.fromLTRB(5, 10, 5, 10)
            ),

            RawMaterialButton(child: 
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

                Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  SizedBox(child: Checkbox(
                    value: randomizeAnswers,
                    onChanged: (v) { randomizeAnswers = !randomizeAnswers; },
                    activeColor: Theme.of(context).primaryColor,
                    visualDensity: VisualDensity.compact,
                  ), width: 20, height: 20),

                  VerticalDivider(width: 10),

                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    Text("Randomize Answers", style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("When enabled, each student will get different arrangements of answers making it even harder to cheat. The servers will automatically check the answers with the correct arrangement in mind.", style: TextStyle(color: Colors.grey)),
                  ],))

                ],),

              ],),
              onPressed: () { randomizeAnswers = !randomizeAnswers; },
              padding: EdgeInsets.fromLTRB(5, 10, 5, 10)
            ),

            Divider(color: Colors.transparent, height: 15),

          ]), padding: EdgeInsets.fromLTRB(18, 15, 18, 0))), padding: EdgeInsets.fromLTRB(15, 15, 15, 15)),

          // Questions and Answers
          Padding(child: Text("Questions and Answers", style: TextStyle(fontWeight: FontWeight.bold, fontSize:20)), padding:EdgeInsets.fromLTRB(25, 5, 25, 0)),
          Padding(child: Divider(), padding:EdgeInsets.fromLTRB(25, 0, 25, 0)),

          if (questions.length > 0)
            Column(children: List.generate(questions.length, (i) {

              return AddQuestionItem(
                index: i,
                question: questions[i],
                correctAnswer: correctAnswers[i],
                saveQuestion: (result) {
                  setState(() {
                    questions[i] = (result["question"] as Question); 
                    correctAnswers[i] = (result["correct"] as int);
                  });
                },
                deleteQuestion: ()
                {
                  setState(() {
                    // remove the question and the correct answer at the given locations
                    questions.removeAt(i);
                    correctAnswers.removeAt(i);
                  });
                },
                changeOrder: (forward)
                {
                  if (forward && i != (questions.length - 1))
                  {
                    var temp = questions[i + 1];

                    setState(() {
                      questions[i + 1] = questions[i];
                      questions[i] = temp;
                    });
                  } 
                  else if (!forward && i != 0)
                  {
                    var temp = questions[i - 1];

                    setState(() {
                      questions[i - 1] = questions[i];
                      questions[i] = temp;
                    });
                  }
                }
              ,);

            }).toList()),
          
          if (questions.length == 0)
            GestureDetector(child: 
              Padding(child: 
                Column(children: <Widget>[
                  Icon(Icons.add, color: Colors.grey, size: 40),
                  Divider(color: Colors.transparent, height: 5),
                  Text("You haven't added any questions yet", style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold)),
                  Text("Tap the + button in the bottom right corner or tap here", style: TextStyle(color: Colors.grey[600], fontSize: 15)),
                ],),
                padding: EdgeInsets.fromLTRB(0, 20, 0, 30)
              ),
              onTap: addQuestion
            ),

          Divider(color: Colors.transparent, height: 75),

        ],),

        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(child: Row(children: <Widget>[
            FloatingActionButton(heroTag: "undo_fab", mini: true, tooltip: "Undo", child: Icon(Icons.undo, size: 18), onPressed: () { },),
            FloatingActionButton(heroTag: "redo_fab", mini: true, tooltip: "Redo", child: Icon(Icons.redo, size: 18), onPressed: () { },),
          ],), padding: EdgeInsets.all(15)) 
        ),

        Align(
          alignment: Alignment.bottomRight,
          child: Padding(child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            FloatingActionButton(heroTag: "add_fab", mini: false, tooltip: "Add new question", child: Icon(Icons.add, size: 18), onPressed: addQuestion,),
          ],), padding: EdgeInsets.all(15)) 
        ),

      ],)),
    ));
  }
}
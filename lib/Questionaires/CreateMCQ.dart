import 'package:humanize/humanize.dart' as humanize;

import 'package:elearnapp/Components/AddQuestionItem.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'MCQ.dart';

class CreateMCQScreen extends StatefulWidget {
  CreateMCQScreen({Key key}) : super(key: key);

  @override
  _CreateMCQScreenState createState() => _CreateMCQScreenState();
}

class _CreateMCQScreenState extends State<CreateMCQScreen> {
  
  bool publishNow = true;
  bool randomizeQuestions = false;
  bool randomizeAnswers = false;

  final TextEditingController titleController = new TextEditingController();
  final TextEditingController subtitleController = new TextEditingController();
  DateTime selectedPublishDateTime;

  List<Question> questions = [
    Question(question: "First question?", answers: ["0.0", "7.0", "3.5", "3.4", "5"]),
    Question(question: "This is the second question?", answers: ["0.0", "7.0", "3.5", "3.4", "5"]),
    Question(question: "third one doe?", answers: ["0.0", "7.0", "3.5", "3.4", "5"]),
    Question(question: "forth one bro?", answers: ["0.0", "7.0", "3.5", "3.4", "5"]),
  ];

  List<int> correctAnswers = [-1,-1,-1,-1];
  
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
      selectedPublishDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onWillPop, child: Scaffold(
      appBar: MainAppBar.get(context, "Create New Questionnaire", poppable: true, done: () { }),
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
            
            Stack(children: <Widget>[
              TextField(
                controller: subtitleController,
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
              AnimatedOpacity(child: Padding(child: Text("Eg:- Computer Engineering 101", style: TextStyle(color: Colors.grey[600])), padding: EdgeInsets.fromLTRB(0, 26, 0, 0),), duration: Duration(milliseconds: 100), opacity: (subtitleController.text == "") ? 1 : 0),
            ],),

            Divider(color: Colors.transparent, height: 5),

            Stack(children: <Widget>[
              TextField(
                controller: subtitleController,
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

          Divider(color: Colors.transparent, height: 75),

        ],),

        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(child: Row(children: <Widget>[
            FloatingActionButton(mini: true, tooltip: "Undo", child: Icon(Icons.undo, size: 18), onPressed: () { },),
            FloatingActionButton(mini: true, tooltip: "Redo", child: Icon(Icons.redo, size: 18), onPressed: () { },),
          ],), padding: EdgeInsets.all(15)) 
        ),

        Align(
          alignment: Alignment.bottomRight,
          child: Padding(child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            FloatingActionButton(mini: false, tooltip: "Create Test", child: Icon(Icons.done, size: 18), onPressed: () { },),
          ],), padding: EdgeInsets.all(15)) 
        ),

      ],)),
    ));
  }

  Future<bool> _onWillPop() {

  }
}
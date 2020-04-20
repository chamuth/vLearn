import 'dart:async';

import 'package:elearnapp/Components/AllQuestionsDisplayItem.dart';
import 'package:elearnapp/Components/MCQAnswerItem.dart';
import 'package:flutter/material.dart';

class MCQScreen extends StatefulWidget {
  MCQScreen({Key key}) : super(key: key);

  @override
  _MCQScreenState createState() => _MCQScreenState();
}

class Question
{
  String question = "";
  List<String> answers = [];
  
  Question({String question, List<String> answers})
  {
    this.question = question;
    this.answers = answers;
  }
}

class _MCQScreenState extends State<MCQScreen> {

  int questionsCount = 50;
  int currentQuestionIndex = 0;
  bool showOverview = false;
  Duration examDuration = Duration(minutes: 30);

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        examDuration = Duration(seconds: examDuration.inSeconds - 1);
      });
    });

    super.initState();
  }

  formatDuration(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  @override
  Widget build(BuildContext context) {

    List<Question> questions = [
      Question(question: "තාප සන්නායකතාවයේ ඒකකය වන්නේ?", answers: [
        "Something wrong", "Jm-1K-1", "J m-1K-1", "J m-1K-1", "J m-1K-1"
      ])
    ];

    return Scaffold(
      body: Stack(children: <Widget>[
      
        IgnorePointer(ignoring: showOverview, child: 
          AnimatedOpacity(child: 
            Container(child: Center(child: ListView(shrinkWrap: true, children: <Widget>[
              
              Padding(padding:EdgeInsets.all(35), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                
                Text("Question " + (currentQuestionIndex + 1).toString() + " / $questionsCount", style: TextStyle(fontSize:16, color: Colors.grey, fontWeight: FontWeight.bold),),
                Divider(height: 10),
                Divider(height: 5, color:Colors.transparent),
                Text(questions[currentQuestionIndex].question, style: TextStyle(fontSize:23, fontWeight: FontWeight.bold),),
                Divider(height: 25, color:Colors.transparent),

                for (var answer in questions[currentQuestionIndex].answers) 
                  MCQAnswerItem(answer: answer, selected: (answer == "naki"),),

                Divider(height: 25, color:Colors.transparent),

                Row(children: <Widget>[
                  Expanded(child: RaisedButton(child: Row(children: <Widget>[
                    Icon(Icons.arrow_back, size:15),
                    VerticalDivider(width:10, color: Colors.transparent),
                    Expanded(child: Text("Previous", textAlign: TextAlign.center,))
                  ],), color:Colors.grey[700], onPressed: () { },), flex: 1),
                  VerticalDivider(width: 10),
                  Expanded(child: RaisedButton(child: Row(children: <Widget>[
                    Expanded(child: Text("Next", textAlign: TextAlign.center,)),
                    VerticalDivider(width:10, color: Colors.transparent),
                    Icon(Icons.arrow_forward, size:15),
                  ],), onPressed: () { },), flex: 1),
                ],),

                Row(children: <Widget>[
                  Expanded(child: RaisedButton(child: Row(children: <Widget>[
                    Icon(Icons.question_answer, size:15),
                    Expanded(child: Text("Questionaire Overview", textAlign: TextAlign.center,))
                  ],), color:Colors.grey[700], onPressed: () { setState(() {
                    showOverview = true;
                  }); },), flex: 1),
                ],)

              ],))

            ],),),),
            opacity:showOverview ? 0 : 1, duration: Duration(milliseconds: 250),
          ),
        ),

        IgnorePointer(ignoring: !showOverview, child:
          AnimatedOpacity(
            child: Container(child: Center(child: ListView(shrinkWrap: true, children: <Widget>[
              Padding(padding:EdgeInsets.all(35), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                
                Row(children: <Widget>[ Expanded(child: Text("All Questions", textAlign: TextAlign.center, style: TextStyle(fontSize:18, fontWeight: FontWeight.bold, color: Colors.grey)))]),
                Divider(height: 15, color:Colors.transparent),

                SizedBox(height: 160, child: 
                  GridView.count(
                    crossAxisCount: 10,
                    children: List.generate(50, (index) {
                      return AllQuestionsDisplayItem(index: index, answered: ([2,22,41,20].contains(index + 1)));
                    }),
                  )
                ),

                Divider(height: 15, color:Colors.transparent),

                Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  SizedBox(child: Container(decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),), width:15, height:15),
                  VerticalDivider(color: Colors.transparent, width: 10),
                  Text("Unanswered"),
                  VerticalDivider(color: Colors.transparent, width: 25),

                  SizedBox(child: Container(decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(5)),), width:15, height:15),
                  VerticalDivider(color: Colors.transparent, width: 10),
                  Text("Already Answered")
                ],),

                Divider(height: 35, color:Colors.transparent),

                Row(children: <Widget>[ Expanded(child: Text("Select questions to answer, tap outwards go back", textAlign: TextAlign.center, style: TextStyle(fontSize:15, color: Colors.grey[600])))]),
              ],))
            ],))),
          duration: Duration(milliseconds: 250), opacity: (!showOverview) ? 0 : 1,)
        ),

        Container(child: Align(alignment: Alignment.topCenter, child: 
          
          Padding(child: 
            Text(formatDuration(examDuration), style: TextStyle(fontSize: 25, fontFamily: "Number"))
          ,padding: EdgeInsets.fromLTRB(0, 70, 0, 0))
        ))

      ],)
    );
  }
}
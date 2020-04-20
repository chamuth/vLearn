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

  List<Question> questions = [
    Question(question: "තාප සන්නායකතාවයේ ඒකකය වන්නේ?", answers: [
      "J m-1K-1", "Jasdm-1K-1", "J m-1K-1", "J m-1K-1", "J m-1K-1"
    ])
  ];

  Widget getAnswersWidget(List<String> answers)
  {
    return new Column(children: answers.map((item) => new MCQAnswerItem(answer: item)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[

        IgnorePointer(ignoring: false, child: 
          AnimatedOpacity(child: 
            Container(child: Center(child: ListView(shrinkWrap: true, children: <Widget>[
              
              Padding(padding:EdgeInsets.all(35), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                
                Text("Question " + (currentQuestionIndex + 1).toString() + " / $questionsCount", style: TextStyle(fontSize:16, color: Colors.grey, fontWeight: FontWeight.bold),),
                Divider(height: 10),
                Divider(height: 5, color:Colors.transparent),
                Text(questions[currentQuestionIndex].question, style: TextStyle(fontSize:23, fontWeight: FontWeight.bold),),
                Divider(height: 25, color:Colors.transparent),

                getAnswersWidget(questions[currentQuestionIndex].answers),

                Divider(height: 25, color:Colors.transparent),

                Row(children: <Widget>[
                  Expanded(child: RaisedButton(child: Row(children: <Widget>[
                    Icon(Icons.arrow_back, size:15),
                    VerticalDivider(width:10, color: Colors.transparent),
                    Expanded(child: Text("Previous", textAlign: TextAlign.center,))
                  ],), onPressed: () { },), flex: 1),
                  VerticalDivider(width: 10),
                  Expanded(child: RaisedButton(child: Row(children: <Widget>[
                    Expanded(child: Text("Next", textAlign: TextAlign.center,)),
                    VerticalDivider(width:10, color: Colors.transparent),
                    Icon(Icons.arrow_forward, size:15),
                  ],), onPressed: () { },), flex: 1),
                ],)

              ],))

            ],),),),
            opacity:1, duration: Duration(milliseconds: 250),
          ),
        ),

        IgnorePointer(ignoring: true, child:
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
                ],)

              ],))
            ],))),
          duration: Duration(milliseconds: 250), opacity: 0,)
        ),
      ],)
    );
  }
}
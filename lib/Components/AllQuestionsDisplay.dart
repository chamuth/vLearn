import 'package:flutter/material.dart';
import 'AllQuestionsDisplayItem.dart';

class AllQuestionsDisplay extends StatefulWidget {
  AllQuestionsDisplay({Key key, this.myAnswers, this.questionsCount, this.onTap }) : super(key: key);

  List<String> myAnswers;
  int questionsCount;
  Function onTap;

  @override
  _AllQuestionsDisplayState createState() => _AllQuestionsDisplayState();
}

class _AllQuestionsDisplayState extends State<AllQuestionsDisplay> {

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: (widget.questionsCount > 5) ? 10 : 5,
      crossAxisSpacing: (widget.questionsCount > 5) ? 2 : 10,
      mainAxisSpacing: (widget.questionsCount > 5) ? 2 : 10,
      shrinkWrap: true,
      children: List.generate(widget.questionsCount, (index) {
        return AllQuestionsDisplayItem(index: index, answered: !(widget.myAnswers[index] == null || widget.myAnswers[index] == "-1" || widget.myAnswers[index].trim() == ""), onTap: widget.onTap,);
      })
    );
  }
}
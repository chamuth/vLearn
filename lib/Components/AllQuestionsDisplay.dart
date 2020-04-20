import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import 'AllQuestionsDisplayItem.dart';

class AllQuestionsDisplay extends StatefulWidget {
  AllQuestionsDisplay({Key key, this.myAnswers, this.questionsCount, this.onTap }) : super(key: key);

  List<int> myAnswers;
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
        return TouchableOpacity(child: AllQuestionsDisplayItem(index: index, answered: !(widget.myAnswers[index] == null || widget.myAnswers[index] == -1)), onTap: () {
          widget.onTap(index);
        },);
      })
    );
  }
}
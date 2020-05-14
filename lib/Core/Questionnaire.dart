class Questionnaire
{
  String title;
  String subtitle;
  List<String> submissions;
  int duration;
  DateTime duedate;
  List<Question> questions;
  List<int> correctAnswers;

  Questionnaire({this.title, this.subtitle, this.duration});
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
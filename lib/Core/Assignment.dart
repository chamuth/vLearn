import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:elearnapp/Questionaires/MCQ.dart';

class Assignment
{
  String id;
  String title;
  String subtitle;
  DateTime duedate;
  Duration duration;
  List submissions;

  Assignment(this.id, this.title, this.subtitle, this.duedate, this.duration, this.submissions);

  static Future<List<Assignment>> getAssignments(String classId) async
  {
    var results = await Firestore.instance.collection("organizations")
      .document(Organization.currentOrganizationId)
      .collection("classes")
      .document(classId)
      .collection("assignments")
      .getDocuments();
    
    return results.documents.map((f) 
    {
      return Assignment(f.documentID, f.data["title"], f.data["subtitle"], (f.data["duedate"] as Timestamp).toDate(), Duration(minutes: f.data["duration"]), f.data["submissions"]);
    }).toList();
  }

  static Future<List<Assignment>> getQuestionnaires(String classId) async
  {
    var results = await Firestore.instance.collection("organizations")
      .document(Organization.currentOrganizationId)
      .collection("classes")
      .document(classId)
      .collection("quests")
      .getDocuments();

    return results.documents.map((f) 
    {
      return Assignment(f.documentID, f.data["title"], f.data["subtitle"], (f.data["duedate"] as Timestamp).toDate(), Duration(minutes: f.data["duration"]), f.data["submissions"]);
    }).toList();
  }

  static Future<List<Question>> getQuestionnaireData(String classId, String qid) async
  {
    var results = await Firestore.instance.collection("organizations")
      .document(Organization.currentOrganizationId)
      .collection("classes")
      .document(classId)
      .collection("quests")
      .document(qid)
      .collection("questions")
      .getDocuments();

    return results.documents.map((f)
    {
      String question = f.data["question"];
      List<String> answers = f.data["answers"];

      return Question(question: question, answers: answers);
    }).toList();
  }
}
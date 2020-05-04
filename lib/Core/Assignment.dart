import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearnapp/Data/Organization.dart';

class Assignment
{
  String id;
  String title;
  String subtitle;
  DateTime duedate;
  Duration duration;

  Assignment(this.id, this.title, this.subtitle, this.duedate, this.duration);

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
      return Assignment(f.documentID, f.data["title"], f.data["subtitle"], (f.data["duedate"] as Timestamp).toDate(), Duration(minutes: f.data["duration"]));
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
      return Assignment(f.documentID, f.data["title"], f.data["subtitle"], (f.data["duedate"] as Timestamp).toDate(), Duration(minutes: f.data["duration"]));
    }).toList();
  }
}
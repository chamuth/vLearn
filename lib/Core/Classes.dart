import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearnapp/Data/Organization.dart';

class ClassData
{
  String id;
  String subject;
  String grade;
  String host;

  ClassData(this.subject, this.grade, this.host);

  static Future<ClassData> getClass(String id) async
  {
    var result = await Firestore.instance.collection("organizations").document(Organization.currentOrganizationId).collection("classes").document(id).get();
    var data = ClassData(result.data["subject"], result.data["grade"], result.data["host"]);
    data.id = id;
    return data;
  }

}
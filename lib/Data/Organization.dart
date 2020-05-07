import 'package:cloud_firestore/cloud_firestore.dart';

class Organization 
{
  static String currentOrganizationId = "qsqL7rxYbQSaEyO37edZ";

  String id = "";
  String name = "";
  String slug = "";
  List subjects = [];
  List grades = [];

  Organization(this.id, this.name, this.slug);

  static Organization me = Organization(currentOrganizationId, "", "");

  static Future<bool> loadCurrentOrganizationDetails() async
  {
    var results = await Firestore.instance.collection("organizations").document(currentOrganizationId).get();

    if (results.exists)
    {
      me.name = results.data["name"];
      me.slug = results.data["slug"];
      me.subjects = results.data["subjects"];
      me.grades = results.data["grades"];
      
      return true;
    } else {
      return false;
    }
  }

}
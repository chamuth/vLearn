import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Organization 
{
  static String currentOrganizationId = "qsqL7rxYbQSaEyO37edZ";

  String id = "";
  String name = "";
  String slug = "";

  Organization(this.id, this.name, this.slug);

  static Organization me = Organization(currentOrganizationId, "", "");

  static Future<bool> loadCurrentOrganizationDetails() async
  {
    var results = await Firestore.instance.collection("organizations").document(currentOrganizationId).get();

    if (results.exists)
    {
      me.name = results.data["name"];
      me.slug = results.data["slug"];
      
      return true;

    } else {
      
      return false;
    }
  }
}
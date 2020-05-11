import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Organization 
{
  static String currentOrganizationId = "qsqL7rxYbQSaEyO37edZ";
  static String organizationLogoUrl;
  static String organizationCoverUrl;

  String id = "";
  String name = "";
  String subtitle = "";
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
      me.subtitle = results.data["subtitle"];
      me.slug = results.data["slug"];
      me.subjects = results.data["subjects"];
      me.grades = results.data["grades"];

      organizationCoverUrl = await getCoverUrl();
      organizationLogoUrl = await getLogoUrl();
      
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getCoverUrl() async
  {
    var ref = FirebaseStorage.instance.ref().child("organizations").child(Organization.me.id).child("organization").child("cover.jpg");
    return (await ref.getDownloadURL()).toString();
  }

  static Future<String> getLogoUrl() async
  {
    var ref = FirebaseStorage.instance.ref().child("organizations").child(Organization.me.id).child("organization").child("logo.png");
    return (await ref.getDownloadURL()).toString();
  }
}
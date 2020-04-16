import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User
{
  String firstName;
  String lastName;
  String email;
  String phone;
  bool teacher;
  String uid;

  static User me = new User();

  static Future retrieveUserData() async
  {
    var user  = await FirebaseAuth.instance.currentUser();
    var ds = await Firestore.instance.collection("users").document(user.uid).get();
    
    me.firstName =  ds.data["fisrt_name"];
    me.lastName =  ds.data["last_name"];
    me.email =  ds.data["email"];
    me.phone =  ds.data["phone"];
    me.teacher =  ds.data["teacher"];
    me.uid =  ds.data["uid"];

    return me;
  }

  static Future getUserData(uid) async
  {
    var result = await Firestore.instance.collection("users").document(uid).get();
    return result;
  }

  static Future getMyClasses() async
  {
    if (me.uid == null)
      await retrieveUserData();

    var result = await Firestore.instance.collection("users").document(me.uid).get();
    var returnClasses = [];

    var classes = result.data["classes"];

    for (var i = 0; i < classes.length; i ++)
    {        
      var classResult = await Firestore.instance.collection("organizations")
        .document(Organization.currentOrganizationId)
        .collection("classes")
        .document(classes[i]).get();
      
      var host = await getUserData(classResult["host"]);

      returnClasses.add({
        "host": host["first_name"] + " " + host["last_name"], 
        "subject" : classResult["subject"],
        "grade" : classResult["grade"]
      });
    }

    return returnClasses;
  }
}
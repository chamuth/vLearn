import 'package:cloud_firestore/cloud_firestore.dart';
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

  static void retrieveUserData() async
  {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance.collection("users").document(user.uid).get().then((DocumentSnapshot ds) {
        me.firstName =  ds.data["fisrt_name"];
        me.lastName =  ds.data["last_name"];
        me.email =  ds.data["email"];
        me.phone =  ds.data["phone"];
        me.teacher =  ds.data["teacher"];
        me.uid =  ds.data["uid"];
      });
    });
  }
}
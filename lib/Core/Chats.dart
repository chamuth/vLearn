import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'User.dart';

class Thread
{
  String title;
  String chatIconURL;
  List<User> participants;

  Thread(this.title, this.participants);
  Thread.empty();
}

class Chats
{
  static Future<List<DatabaseReference>> loadChats() async
  {
    var user = await User.getUserData(User.me.uid);
    List threadStructure = user.data["threads"];

    List<DatabaseReference> threads = threadStructure.map((t) {
      var threadId = t.toString();

      return FirebaseDatabase.instance.reference().child("threads").child(threadId);
    }).toList();
    
    return threads;
  }
}
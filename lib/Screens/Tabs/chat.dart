import 'dart:math';

import 'package:elearnapp/Components/ConversationItem.dart';
import 'package:elearnapp/Core/Chats.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Screens/Represents/ConversationThreadView.dart';
import 'package:faker/faker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatTab extends StatefulWidget {
  ChatTab({Key key}) : super(key: key);

  @override
  ChatTabState createState() => ChatTabState();
}

class ChatTabState extends State<ChatTab> {
  
  List<Thread> myChats = [];

  void loadChats() async
  {
    // load shared preferences
    
    var chats = await Chats.loadChats();
    List<Thread> threads = [];

    for (var i = 0; i < chats.length; i++)
    {
      // TODO: Implement caching messages
      
      var snap = await chats[i].once();
      var thread = Thread.empty();

      thread.participants = [];
      
      // get participant information
      for (var j = 0; j < snap.value["participants"].length; j++)
      {
        var participantId = snap.value["participants"][j];
        
        if (participantId != User.me.uid)
        {
          // If the user is not myself
          var participant = await User.getUser(participantId);
          thread.participants.add(participant);

        }
      }

      // set the conversation title
      if (thread.participants.length == 1)
        thread.title = User.getSanitizedName(thread.participants[0]);

      
      var last = (snap.value["thread"] as List).last;
      var senderName = "";

      if (last["sender"] == User.me.uid)
        senderName = "You";
      else 
      {
        senderName = thread.participants.where((u) {
          return (u.uid == last["sender"]);
        }).first.firstName;
      }
      thread.lastMessage = Message(last["sender"], senderName, last["content"], last["messageType"]);

      threads.add(thread);
    }

    setState(() {
      myChats = threads;
    });
  }

  @override
  void initState() {
    loadChats();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(itemCount: myChats.length, itemBuilder: (context, index) {
      return RawMaterialButton(
        child: ConversationItem(
          conversationTitle: myChats[index].title,
          lastMessage: myChats[index].lastMessage, 
          unreadMessages: 0,
        ), onPressed: () { 

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConversationThreadView(thread: myChats[index]),
            )
          );

        }
      );
    });
  }
}
import 'dart:math';

import 'package:elearnapp/Components/ConversationItem.dart';
import 'package:elearnapp/Core/Chats.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Screens/Represents/ConversationThreadView.dart';
import 'package:faker/faker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class ChatTab extends StatefulWidget {
  ChatTab({Key key}) : super(key: key);

  @override
  ChatTabState createState() => ChatTabState();
}

class ChatTabState extends State<ChatTab> {
  
  List<Thread> myChats = [];
  bool threadsReady = false;

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
      if (snap.value["participants"].length == 2)
      {
        for (var j = 0; j < snap.value["participants"].length; j++)
        {
          var participantId = snap.value["participants"][j];
          
          if (participantId != User.me.uid)
          {
            // If the user is not myself
            try {
              var participant = await User.getUser(participantId);
              thread.participants.add(participant);

              break;
            } catch (e) {
              print(participantId);
            }
          }
        }
      }

      thread.group = (snap.value["participants"].length > 2);

      // set the conversation title
      if (thread.participants.length == 1)
        thread.title = User.getSanitizedName(thread.participants[0]);
      else 
        thread.title = snap.value["title"] ?? "Group Chat";

      thread.threadId = snap.key;
      
      var last = (snap.value["thread"] as List).last;
      var senderName = "";

      if (last["sender"] == User.me.uid)
        senderName = "You";
      else 
      {
        senderName = last["senderName"];
      }
      thread.lastMessage = Message(last["sender"], senderName, last["content"], last["messageType"]);

      threads.add(thread);
    }
    if (this.mounted){
      setState(() {
        myChats = threads;
        threadsReady = true;
      });
    }
  }

  @override
  void initState() {
    loadChats();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedCrossFade(
      firstChild: ListView.builder(shrinkWrap: true, itemCount: myChats.length, itemBuilder: (context, index) {
        return RawMaterialButton(
          child: ConversationItem(
            conversationTitle: myChats[index].title,
            lastMessage: myChats[index].lastMessage, 
            unreadMessages: 0,
            group: myChats[index].group
          ), onPressed: () { 

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConversationThreadView(threadId: myChats[index].threadId),
              )
            );

          }
        );
      }),
      secondChild: IgnorePointer(child: ListView.builder(shrinkWrap: true, itemBuilder: (ctx, index) {
        var rand = RandomGenerator();

        return Padding(child: Row(children: <Widget>[

          Padding(
            child: Shimmer.fromColors(child: CircleAvatar(), baseColor: Theme.of(context).cardColor,highlightColor: Colors.grey[500],), 
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0)
          ),

          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

              SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Theme.of(context).cardColor,highlightColor: Colors.grey[500]),
              width: MediaQuery.of(context).size.width * random.decimal(scale: 0.5, min: 0.2), height: 20),
              SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Theme.of(context).cardColor,highlightColor: Colors.grey[500]), 
              width: MediaQuery.of(context).size.width * random.decimal(scale: 0.8, min: 0.3), height: 18),

            ],)
          )
          
        ],), padding: EdgeInsets.fromLTRB(15, 10, 15, 10),);
      }, itemCount: 15,), ignoring: true,),
      duration: Duration(milliseconds: 350), crossFadeState: (threadsReady) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );

  }
}
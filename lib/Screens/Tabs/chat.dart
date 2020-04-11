import 'package:elearnapp/Components/ConversationItem.dart';
import 'package:flutter/material.dart';

class ChatTab extends StatefulWidget {
  ChatTab({Key key}) : super(key: key);

  @override
  ChatTabState createState() => ChatTabState();
}

class ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      RawMaterialButton(child: ConversationItem(conversationTitle: "Mr. John Doe", lastMessage: "Last conversation is good...",unreadMessages: 12,), onPressed: () { }),
      RawMaterialButton(child: ConversationItem(conversationTitle: "Mr. John Doe", lastMessage: "Last conversation is good...",unreadMessages: 3,), onPressed: () { }),
      RawMaterialButton(child: ConversationItem(conversationTitle: "Mr. John Doe", lastMessage: "Last conversation is good...",unreadMessages: 2,), onPressed: () { }),
      RawMaterialButton(child: ConversationItem(conversationTitle: "Mr. John Doe", lastMessage: "Last conversation is good...",unreadMessages: 0,), onPressed: () { }),
    ],);
  }
}
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class ConversationItem extends StatefulWidget {
  ConversationItem({Key key, this.conversationTitle, this.lastMessage, this.unreadMessages}) : super(key: key);

  int unreadMessages = 2;
  String conversationTitle = "Mr. John Doe";
  String lastMessage = "Hey there...";

  @override
  _ConversationItemState createState() => _ConversationItemState();
}

class _ConversationItemState extends State<ConversationItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Row(children: <Widget>[
         Padding(child: CircleAvatar(child: Text("J"), backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white,), padding: EdgeInsets.fromLTRB(0, 0, 15, 0)),
         Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
           Text(widget.conversationTitle, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
           Divider(height: 2, color: Colors.transparent),
           Text(widget.lastMessage, style: TextStyle(color: Colors.grey[400], fontSize:15))
         ],)),

        if (widget.unreadMessages > 0)
          Badge(badgeContent: Text(widget.unreadMessages.toString(), style:TextStyle(fontSize:17)),),

        VerticalDivider(color: Colors.transparent, width:5),
       ],), padding: EdgeInsets.fromLTRB(15, 10, 15, 10)
    );
  }
}
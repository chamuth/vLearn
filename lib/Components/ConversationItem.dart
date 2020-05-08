import 'package:badges/badges.dart';
import 'package:elearnapp/Core/Chats.dart';
import 'package:flutter/material.dart';

class ConversationItem extends StatefulWidget {
  ConversationItem({Key key, this.conversationTitle, this.lastMessage, this.unreadMessages, this.group}) : super(key: key);

  int unreadMessages = 2;
  String conversationTitle = "Mr. John Doe";
  Message lastMessage;
  bool group = false;

  @override
  _ConversationItemState createState() => _ConversationItemState();
}

class _ConversationItemState extends State<ConversationItem> {
  @override
  Widget build(BuildContext context) {    
    return Container(
       child: Row(children: <Widget>[
         Padding(child: CircleAvatar(child: 
          (widget.group) ? Icon(Icons.group, size: 20) : Text(widget.conversationTitle.substring(0,1)
         ), backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white,), padding: EdgeInsets.fromLTRB(0, 0, 15, 0)),
         Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(widget.conversationTitle, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          Divider(height: 2, color: Colors.transparent),
          if (widget.lastMessage.messageType == "text")
            Row(children: <Widget>[
              Text(widget.lastMessage.senderName + ": "),
              Expanded(child: Text((widget.lastMessage.content.length > 30) ? widget.lastMessage.content.substring(0, 30) + "..." : widget.lastMessage.content, style: TextStyle(color: Colors.grey[400], fontSize:15)))
            ],),
          if (widget.lastMessage.messageType == "draft")
            Row(children: <Widget>[
              Expanded(child: Text((widget.lastMessage.content.length > 35) ? widget.lastMessage.content.substring(0, 35) + "..." : widget.lastMessage.content, style: TextStyle(color: Colors.grey[400], fontSize:15, fontStyle: FontStyle.italic)))
            ],),
         ],)),

        if (widget.unreadMessages > 0)
          Badge(badgeContent: Text(widget.unreadMessages.toString(), style:TextStyle(fontSize:17)),),

        VerticalDivider(color: Colors.transparent, width:5),
       ],), padding: EdgeInsets.fromLTRB(15, 10, 15, 10)
    );
  }
}
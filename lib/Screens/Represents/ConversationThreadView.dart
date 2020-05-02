import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:elearnapp/Core/Chats.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:faker/faker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'ProfileView.dart';


class ConversationThreadView extends StatefulWidget {
  ConversationThreadView({Key key, this.threadId}) : super(key: key);

  String threadId;

  @override
  _ConversationThreadViewState createState() => _ConversationThreadViewState();
}

class LocalMessage 
{
  String content;
  MessageStatus messageStatus;
  MessageItemType type;
  DateTime sent;
  String senderName;
  String sender;

  LocalMessage({this.content, this.messageStatus, this.type, this.sent, this.senderName, this.sender,});
}

enum MessageItemType
{
  Message, DateTime, Start
}

enum MessageStatus
{
  Sending, Sent, Received, Seen, Incoming
}

class _ConversationThreadViewState extends State<ConversationThreadView> {

  // List<LocalMessage> messages = Faker().lorem.sentences(55).map((s) => LocalMessage(type: MessageItemType.Message, content: s, messageStatus: (random.boolean()) ? MessageStatus.Incoming : MessageStatus.Sent)).toList();
  List<LocalMessage> messages = [];
  List _messages = [];
  bool group = false;
  List peopleIds = [];
  User person = User.fromName("Chamuth", "Chamandana");
  String chatTitle = "Loading...";
  DateTime lastSeen = DateTime.now();
  bool lastSeenListenerSet = false;

  bool firstTime = true;

  void loadMessages() async
  {
    var ref = Chats.loadChat(widget.threadId);

    ref.onValue.listen((dat) {
      
      if (firstTime)
      {
        firstTime = false;
        if (dat.snapshot.value["title"] == null)
        {
          if (dat.snapshot.value["participants"].length > 2)
          {
            // group chat naming
            setState(() {
              group = true; 
              chatTitle = "Group Chat";
              peopleIds = dat.snapshot.value["participants"];
            });

          } else {
            setState(() {
              group = false;
            });

            for(var i = 0; i < dat.snapshot.value["participants"].length; i++)
            {
              var p = dat.snapshot.value["participants"][i];

              if (p != User.me.uid)
              {
                User.getUser(p).then((user) 
                {
                  setState(() {
                    person = user;
                    chatTitle = User.getSanitizedName(user);
                  });
                });

                if (lastSeenListenerSet == false)
                {
                  User.getLastOnline(p).onValue.listen((onlineVal) {
                    setState(() {
                      lastSeen = DateTime.parse(onlineVal.snapshot.value["last_online"] ?? DateTime.now());
                    });
                  });

                  lastSeenListenerSet = true;
                }
              }
            }
          }
        } else {
          setState(() {
            if (dat.snapshot.value["participants"].length > 2)
              group = true;

            chatTitle = dat.snapshot.value["title"];
            peopleIds = dat.snapshot.value["participants"];
          });
        }
      }

      // get the messages
      _messages = dat.snapshot.value["thread"];
      
      renderMessages();
    });
  }

  void renderMessages()
  {
    List<LocalMessage> list = [];

    for(var i = _messages.length - 1; i >= 0; i--)
    {
      var message = _messages[i];

      LocalMessage local = LocalMessage(
        content: message["content"], 
        messageStatus: (message["sender"] == User.me.uid) ? MessageStatus.Sent : MessageStatus.Incoming, 
        type: MessageItemType.Message,
        sent: DateTime.parse(message["created"]),
        senderName: message["senderName"],
        sender: message["sender"]
      );

      list.add(local);

      if (i > 0)
      {
        if (_messages[i - 1] != null)
        {
          var date1 = DateTime.parse(message["created"]);
          var date2 = DateTime.parse(_messages[i - 1]["created"]);
          var difference = date1.difference(date2);

          if (difference.inHours > 24)
          {
            list.add(LocalMessage(type: MessageItemType.DateTime, sent: DateTime.parse(message["created"])));
          }
        }
      }
    }

    // add the chat start identifier
    list.add(LocalMessage(type: MessageItemType.DateTime, sent: DateTime.parse(_messages[0]["created"])));
    list.add(LocalMessage(type: MessageItemType.Start));

    setState(() {
      messages = list;
    });
  }

  @override
  void initState() {
    loadMessages();

    // set My last seen time 
    User.setLastOnline(User.me.uid, DateTime.now());

    super.initState();
  }

  final TextEditingController messageTextController = new TextEditingController();

  void sendMessage() async
  {
    if (messageTextController.text != "")
    {
      var msg = Message.empty();
      msg.content = messageTextController.text;
      msg.messageType = "text";
      msg.sender = User.me.uid;

      // add the message temporarily before sending
      var rev = messages.reversed.toList();
      rev.add(LocalMessage(content: messageTextController.text, messageStatus: MessageStatus.Sending, sender: User.me.uid, sent: DateTime.now(), type: MessageItemType.Message));

      // reset the text
      messageTextController.text = "";
      
      if (mounted)
      {
        setState(() {
          messages = rev.reversed.toList();  
        });
      }

      Chats.sendMessage(widget.threadId, msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: RawMaterialButton(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
          if (group)
            CircleAvatar(child: Icon(Icons.group, size: 20), backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white,),
          if (!group)
            CircleAvatar(child: Text((person.firstName != null) ? person.firstName.substring(0,1) : ""), backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white,),

          VerticalDivider(color: Colors.transparent, width: 12),

          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(chatTitle, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Divider(height: 2, color: Colors.transparent),
            if (!group)
              Text(((lastSeen.second < 60) ? "online" : "last seen " + timeago.format(lastSeen)), style: TextStyle(fontSize: 14, color: Colors.grey)),
            if (group)
              Text(peopleIds.length.toString() + " members", style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],),

        ],), onPressed: () { 
          if (!group)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileView(uid: person.uid)
              )
            );
          } else {

          }
        },),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Navigator.maybePop(context); }),
        actions: <Widget>[
          Padding(child: IconButton(tooltip: "Chat Information", icon: Icon(Icons.info_outline), onPressed: (){
            Navigator.of(context).maybePop();
          },), padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
        ],
        backgroundColor: Theme.of(context).backgroundColor,
      ),

      body: Container(child: Stack(children: <Widget>
      [
        // Conversation items list
        ListView.builder(shrinkWrap: false, reverse: true,scrollDirection: Axis.vertical, itemBuilder: (context, i)
        {
          if (messages[i].type == MessageItemType.Message)
          {
            return Padding(child: 
            Align(
              alignment: (messages[i].messageStatus != MessageStatus.Incoming) ? Alignment.centerRight : Alignment.centerLeft, 
              child: Container(
                constraints:  BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), 
                  color: (messages[i].messageStatus != MessageStatus.Incoming) ? Colors.blue : Colors.grey[700]
                ), 
                child: Stack(children: <Widget>[
                  
                  Padding(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      if (group && messages[i].sender != User.me.uid && messages[i].senderName != null)
                        Opacity(child: Text(messages[i].senderName ?? "", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.start), opacity:0.65),

                      Text(messages[i].content ?? "", style: TextStyle(fontSize: 17,), textAlign: TextAlign.start), 
                    ],),
                    padding:
                      (group) ?
                     EdgeInsets.fromLTRB(9, 5, (messages[i].messageStatus == MessageStatus.Incoming) ? 50 : 70, 6) : 
                     EdgeInsets.fromLTRB(10, 8, (messages[i].messageStatus == MessageStatus.Incoming) ? 50 : 70, 8)
                  ),

                  Positioned(bottom: 5, right: 8, child: Opacity(child: Row(children: <Widget>[
                    Text(messages[i].sent.hour.toString().padLeft(2, "0") + ":" + messages[i].sent.minute.toString().padLeft(2, "0"), style: TextStyle(fontSize: 13)),
                    if (messages[i].messageStatus != MessageStatus.Incoming)
                      VerticalDivider(color: Colors.transparent, width:5),
                    if (messages[i].messageStatus != MessageStatus.Incoming)
                      Icon((messages[i].messageStatus == MessageStatus.Sending) ? Icons.timer : Icons.done, size: 14),
                  ]), opacity: 0.65)),
                  
                ],)
              )
            ), 
            padding: EdgeInsets.fromLTRB(15, 
            (messages[i].sender == messages[i + 1].sender) ?
              2 : 7 
            , 15, (i == 0) ? 85 : 3));
          }
          else if (messages[i].type == MessageItemType.Start)
          {
            return Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 0));
          } else if (messages[i].type == MessageItemType.DateTime)
          {            
            return Padding(
              child: Seperator(title: 
                (DateTime.now().difference(messages[i].sent).inHours < 24) 
                  ? "Today" 
                  : messages[i].sent.day.toString() + "/" + messages[i].sent.month.toString() + "/" + messages[i].sent.year.toString()
              ), 
              padding: EdgeInsets.fromLTRB(10, 0, 10, 5)
            );
          }
          return Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 5));
        }, itemCount: messages.length),

        // Text Fader
        Align(alignment: Alignment.bottomCenter, child: Container(
          height: 75,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Theme.of(context).backgroundColor.withOpacity(0),
                Theme.of(context).backgroundColor.withOpacity(1),
              ],
              stops: [0.0, 1.0]
            )
          ),
        ),),

        // Chat textbox
        Align(alignment: Alignment.bottomCenter, child: SizedBox(width: MediaQuery.of(context).size.width, child: 
          Padding(
            child: Card(clipBehavior: Clip.antiAlias,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), color:Colors.grey[800], 
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                Expanded(
                  child: Padding(
                    child: TextFormField(style: TextStyle(fontSize: 17), 
                      decoration: InputDecoration(
                        hintText: "Enter your message here",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      controller: messageTextController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    
                    textCapitalization: TextCapitalization.sentences,
                  ), padding: EdgeInsets.fromLTRB(17, 0, 10, 1)),
                ),

                IconButton(icon: Icon(Icons.attach_file), tooltip: "Attach a file", onPressed: () {},),
                IconButton(icon: Icon(Icons.send), tooltip: "Send message", onPressed: () {
                  sendMessage();
                },)
              ],), 
            ),
            padding: EdgeInsets.fromLTRB(12,12,12,12)
          )
        ))
      ],),),
  
    );
  }
}
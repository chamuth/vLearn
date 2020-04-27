import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class ConversationThreadView extends StatefulWidget {
  ConversationThreadView({Key key}) : super(key: key);

  @override
  _ConversationThreadViewState createState() => _ConversationThreadViewState();
}

class Message 
{
  String content;
  MessageStatus messageStatus;
  MessageItemType type;
  DateTime sent;

  Message({this.content, this.messageStatus, this.type, this.sent});
}

enum MessageItemType
{
  Message, DateTime, Start
}

enum MessageStatus
{
  Sent, Received, Seen, Incoming
}

class _ConversationThreadViewState extends State<ConversationThreadView> {

  List<Message> messages = Faker().lorem.sentences(55).map((s) => Message(type: MessageItemType.Message, content: s, messageStatus: (random.boolean()) ? MessageStatus.Incoming : MessageStatus.Sent)).toList();

  @override
  void initState() {
    setState(() {
      messages.add(Message(type: MessageItemType.Start));
      var indices = random.numbers(55, 4);
      indices.forEach((f) {
        messages.insert(f, Message(type: MessageItemType.DateTime));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
          CircleAvatar(child: Text("C")),

          VerticalDivider(color: Colors.transparent, width: 12),

          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text("Chamuth Chamandana", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Divider(height:2, color: Colors.transparent),
            Text("last seen at 01:28", style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],),

        ],),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () { }),
        actions: <Widget>[
          Padding(child: IconButton(tooltip: "Chat Information", icon: Icon(Icons.info_outline), onPressed: (){

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
                    child: Text(messages[i].content, style: TextStyle(fontSize: 17,), textAlign: TextAlign.start), 
                  padding: EdgeInsets.fromLTRB(10, 8, 58, 8)),

                  Positioned(bottom: 8, right: 8, child: Opacity(child: Row(children: <Widget>[
                    Text("11:52"),
                    if (messages[i].messageStatus != MessageStatus.Incoming)
                      VerticalDivider(color: Colors.transparent, width:5),
                    if (messages[i].messageStatus != MessageStatus.Incoming)
                      Icon(Icons.done_all, size: 15),
                  ]), opacity: 0.65)),
                  
                ],)
              )
            ), 
            padding: EdgeInsets.fromLTRB(15, (messages[i+1].messageStatus != messages[i].messageStatus) ? 8: 3, 15, (i == 0) ? 85 : 3));
          }
          else if (messages[i].type == MessageItemType.Start)
          {
            return Padding(child: Seperator(title: "The chat starts here!"), padding: EdgeInsets.fromLTRB(10, 10, 10, 5));
          } else if (messages[i].type == MessageItemType.DateTime)
          {
            return Padding(child: Seperator(title: "April 14"), padding: EdgeInsets.fromLTRB(10, 10, 10, 5));
          }
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
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    
                    textCapitalization: TextCapitalization.sentences,
                  ), padding: EdgeInsets.fromLTRB(17, 0, 10, 1)),
                ),

                IconButton(icon: Icon(Icons.attach_file), tooltip: "Attach a file", onPressed: () {},),
                IconButton(icon: Icon(Icons.send), tooltip: "Send message", onPressed: () {},)
              ],), 
            ),
            padding: EdgeInsets.fromLTRB(12,12,12,12)
          )
        ))
      ],),),
    );
  }
}
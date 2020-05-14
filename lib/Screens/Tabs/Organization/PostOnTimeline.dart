import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Core/Events.dart';
import 'package:flutter/material.dart';

class PostOnTimeline extends StatefulWidget {
  PostOnTimeline({Key key}) : super(key: key);

  @override
  _PostOnTimelineState createState() => _PostOnTimelineState();
}

class _PostOnTimelineState extends State<PostOnTimeline> {

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController descriptionController = new TextEditingController();
  EventType eventType = EventType.album;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.get(context, "Post on School Timeline", poppable: true, done: () {

      }),
      body: Column(children: <Widget>[
        Expanded(child: ListView(children: <Widget>[
          Text("Select Post Type"),

          DropdownButton(items: <DropdownMenuItem> [
            DropdownMenuItem(child: Text("Event Album"), value: EventType.album,),
            DropdownMenuItem(child: Text("Celebration"), value: EventType.celebration),
          ], onChanged: (value) { eventType = value; }, value: eventType, isExpanded: true),

          Divider(color: Colors.transparent, height: 5),

          Stack(children: <Widget>[
            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always, 
                labelText: 'Event Name',
                contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                labelStyle: TextStyle(fontSize: 20, color: Colors.grey[300]),
                alignLabelWithHint: true,
                suffixIcon: AnimatedOpacity(child: Padding(child: Icon(Icons.done, color: Colors.green, size: 20), padding: EdgeInsets.fromLTRB(15,10,0,0)), opacity:0, duration: Duration(milliseconds: 100)),
              )
            ),
            IgnorePointer(ignoring: true, child: AnimatedOpacity(child: Padding(child: Text("Eg:- Science Day 2020", style: TextStyle(color: Colors.grey[600])), padding: EdgeInsets.fromLTRB(0, 26, 0, 0),), duration: Duration(milliseconds: 100), opacity: (nameController.text == "") ? 1 : 0))
          ],),

          Divider(color: Colors.transparent, height: 10),

          Stack(children: <Widget>[
            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 10,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always, 
                labelText: 'Event Description',
                contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                labelStyle: TextStyle(fontSize: 20, color: Colors.grey[300]),
                alignLabelWithHint: true,
                suffixIcon: AnimatedOpacity(child: Padding(child: Icon(Icons.done, color: Colors.green, size: 20), padding: EdgeInsets.fromLTRB(15,10,0,0)), opacity:0, duration: Duration(milliseconds: 100)),
              )
            ),
            IgnorePointer(ignoring: true, child: AnimatedOpacity(child: Padding(child: Text("Optional description for the event", style: TextStyle(color: Colors.grey[600])), padding: EdgeInsets.fromLTRB(0, 26, 0, 0),), duration: Duration(milliseconds: 100), opacity: (nameController.text == "") ? 1 : 0))
          ],),

          Divider(color: Colors.transparent, height: 25),

          Text("Photos and Videos"),

          SizedBox(child: GridView.count(shrinkWrap: false, crossAxisCount: 2, children: List.generate(10, (index) {
            return Image(image: AssetImage("assets/images/45593361_526088287868521_6651631862953279488_n.jpg"));
          }),), height: 50)

        ], padding: EdgeInsets.fromLTRB(20, 10, 20, 10),),),

        Padding(padding: EdgeInsets.fromLTRB(15, 10, 15, 10), child: RaisedButton(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Icon(Icons.public, size: 20),
          VerticalDivider(width:10),
          Text("Publish Post", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))
        ]), color: Theme.of(context).primaryColor, onPressed: () { 

        }, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),))

      ])
    );
  }
}
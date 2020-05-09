import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateMCQScreen extends StatefulWidget {
  CreateMCQScreen({Key key}) : super(key: key);

  @override
  _CreateMCQScreenState createState() => _CreateMCQScreenState();
}



class _CreateMCQScreenState extends State<CreateMCQScreen> {
  
  bool publishNow = true;
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController subtitleController = new TextEditingController();
  
  @override
  void initState() {
    super.initState();
  }

  void selectPublishDate()
  {
    
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onWillPop, child: Scaffold(
      appBar: MainAppBar.get(context, "Create New Questionnaire", poppable: true, done: () { }),
      body: Container(color: Colors.grey[900], child: ListView(children: <Widget>[

        // BASIC INFORMATION CARD
        Padding(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Padding(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Row(children: <Widget>[
            Icon(Icons.view_list, size: 20, color: Colors.grey[200]),
            VerticalDivider(width: 12),
            Text("Basic Information", style: TextStyle(color: Colors.grey[200], fontSize: 22, fontWeight: FontWeight.bold)),
          ]),

          Divider(color: Colors.transparent, height: 12),
          
          Stack(children: <Widget>[
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always, 
                labelText: 'Questionnaire Title',
                contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                labelStyle: TextStyle(fontSize: 20, color: Colors.grey[300]),
                alignLabelWithHint: true,
                suffixIcon: AnimatedOpacity(child: Padding(child: Icon(Icons.done, color: Colors.green, size: 20), padding: EdgeInsets.fromLTRB(15,10,0,0)), opacity:0, duration: Duration(milliseconds: 100)),
                helperText: "Title of the unit, lesson, or major heading"
              )
            ),
            AnimatedOpacity(child: Padding(child: Text("Eg:- Computer Engineering 101", style: TextStyle(color: Colors.grey[600])), padding: EdgeInsets.fromLTRB(0, 26, 0, 0),), duration: Duration(milliseconds: 100), opacity: (subtitleController.text == "") ? 1 : 0),
          ],),

          Divider(color: Colors.transparent, height: 5),

          Stack(children: <Widget>[
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always, 
                labelText: 'Questionnaire Subtitle',
                contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                alignLabelWithHint: true,
                labelStyle: TextStyle(fontSize: 20, color: Colors.grey[300]),
                suffixIcon: AnimatedOpacity(child: Padding(child: Icon(Icons.done, color: Colors.green, size: 20), padding: EdgeInsets.fromLTRB(15,10,0,0)), opacity:0, duration: Duration(milliseconds: 100)),
                helperText: "Name of the test with number or sub-heading"
              )
            ),
            AnimatedOpacity(child: Padding(child: Text("Eg:- Data Structures Test 1", style: TextStyle(color: Colors.grey[600])), padding: EdgeInsets.fromLTRB(0, 26, 0, 0),), duration: Duration(milliseconds: 100), opacity: (subtitleController.text == "") ? 1 : 0),
          ],),

          Divider(height: 25),

          Text("Questionnaire Publishing", style: TextStyle(fontSize: 15, color: Colors.grey[300])),
          Divider(color: Colors.transparent, height: 5),

          RawMaterialButton(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

              Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                SizedBox(child: Checkbox(
                  value: publishNow,
                  onChanged: (v) { publishNow = !publishNow; },
                  activeColor: Theme.of(context).primaryColor,
                  visualDensity: VisualDensity.compact,
                ), width: 20, height: 20),

                VerticalDivider(width: 10),

                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Text("Publish Now", style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("You can publish this questionnaire to your students now or you can set a date and time for this questionnaire to be released", style: TextStyle(color: Colors.grey)),
                ],))

              ],),

            ],),
            onPressed: () { publishNow = !publishNow; },
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10)
          ),

          Divider(color: Colors.transparent, height: 10),

          AnimatedCrossFade(crossFadeState: (publishNow) ? CrossFadeState.showFirst : CrossFadeState.showSecond, firstChild: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text("Publish Date and Time", style: TextStyle(fontSize: 15, color: Colors.grey[300])),
            Divider(color: Colors.transparent, height: 5),
            
            RawMaterialButton(child: Row(children: <Widget>[
                Expanded(child: Text(DateTime.now().toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[300]))),
                Text("Tap to set date", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold))
              ],),
              onPressed: () {
                selectPublishDate();
              },
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),

            Divider(color: Colors.transparent, height: 15),
          ],), secondChild: Container(), duration: Duration(milliseconds: 200))

        ]), padding: EdgeInsets.fromLTRB(18, 15, 18, 0))), padding: EdgeInsets.fromLTRB(15, 15, 15, 15)),

        // Questions and Answers
        Padding(child: Text("Questions and Answers", style: TextStyle(fontWeight: FontWeight.bold, fontSize:20)), padding:EdgeInsets.fromLTRB(25, 5, 25, 0)),
        Padding(child: Divider(), padding:EdgeInsets.fromLTRB(25, 0, 25, 0)),

        Column(children: List.generate(10, (i) {

          return Padding(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Padding(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Row(children: <Widget>[
              Icon(Icons.live_help, size: 18, color: Colors.grey[200]),
              VerticalDivider(width: 12),
              Text("Question #" + (i + 1).toString(), style: TextStyle(color: Colors.grey[200], fontSize: 20, fontWeight: FontWeight.bold)),
            ]),

          ]), padding: EdgeInsets.fromLTRB(18, 13, 18, 13))), padding: EdgeInsets.fromLTRB(15, 5, 15, 5));

        }).toList()),

      ],)),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () {}, tooltip: "Add new question"),
    ));
  }

  Future<bool> _onWillPop() {

  }
}
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateMCQScreen extends StatefulWidget {
  CreateMCQScreen({Key key}) : super(key: key);

  @override
  _CreateMCQScreenState createState() => _CreateMCQScreenState();
}

final TextEditingController titleController = new TextEditingController();
final TextEditingController subtitleController = new TextEditingController();

class _CreateMCQScreenState extends State<CreateMCQScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onWillPop, child: Scaffold(
      appBar: MainAppBar.get(context, "Create New Questionnaire", poppable: true, done: () { }),
      body: Container(color: Colors.grey[900], child: ListView(children: <Widget>[
        Padding(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Padding(child: Column(children: <Widget>[
          Row(children: <Widget>[
            Icon(Icons.view_list, size: 20, color: Colors.grey),
            VerticalDivider(width: 12),
            Text("Basic Information", style: TextStyle(color: Colors.grey, fontSize: 22, fontWeight: FontWeight.bold)),
          ]),

          Divider(color: Colors.transparent, height: 10),
          
          Stack(children: <Widget>[
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(floatingLabelBehavior: FloatingLabelBehavior.always, labelText: 'Questionnaire Subtitle', contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0), alignLabelWithHint: true)
            ),
            AnimatedOpacity(child: Padding(child: Text("Eg:- Computer Engineering 101", style: TextStyle(color: Colors.grey[600])), padding: EdgeInsets.fromLTRB(0, 26, 0, 0),), duration: Duration(milliseconds: 100), opacity: (subtitleController.text == "") ? 1 : 0),
          ],),

          Divider(color: Colors.transparent, height: 3),

          Stack(children: <Widget>[
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(floatingLabelBehavior: FloatingLabelBehavior.always, labelText: 'Questionnaire Subtitle', contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0), alignLabelWithHint: true)
            ),
            AnimatedOpacity(child: Padding(child: Text("Eg:- Data Structures Test 1", style: TextStyle(color: Colors.grey[600])), padding: EdgeInsets.fromLTRB(0, 26, 0, 0),), duration: Duration(milliseconds: 100), opacity: (subtitleController.text == "") ? 1 : 0),
          ],),

        ]), padding: EdgeInsets.fromLTRB(15, 12, 15, 15))), padding: EdgeInsets.fromLTRB(15, 15, 15, 15))
      ],)),
    ));
  }

  Future<bool> _onWillPop() {

  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../start.dart';

class Register3Screen extends StatefulWidget {
  Register3Screen({Key key}) : super(key: key);

  @override
  _Register3ScreenState createState() => _Register3ScreenState();
}

class _Register3ScreenState extends State<Register3Screen> {

  DateTime selectedDate;

  void selectBirthday(BuildContext context) async
  {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: (selectedDate ?? DateTime.now()),
      firstDate: DateTime(1900,1),
      lastDate: DateTime.now()
    );

    if (picked != null && picked != selectedDate)
    {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String processBirthdayToString()
  {
    var date = selectedDate ?? DateTime.now();
    return date.day.toString() + "/" + date.month.toString() + "/" + date.year.toString();
  }

  String selectedGrade;
  List<String> grades = ["Grade 1", "Grade 2", "Grade 3", "Grade 4", "Grade 5", "Grade 6", "Grade 7", "Grade 8", "Grade 9", "Grade 10", "Grade 11", "Grade 12", "Grade 13"];

  @override
  void initState() {

    setState(() {
      grades = Organization.me.grades.map((x) => x.toString()).toList();
    });

    super.initState();
  }

  void saveSettings()
  {
    var grade = grades.indexOf(selectedGrade);
    var birthday = selectedDate;

    if (grade != -1 && DateTime.now().difference(birthday).inDays < (365 * 100)) 
    {
      setState(() {
        submitting = true;
      });

      Firestore.instance.collection("users").document(User.me.uid).updateData({
        "birthday" : birthday,
        "grade" : grade,
      }).then((val) {
        // send the user to start screen
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => StartScreen()),
        );
      }).catchError((err) {
        
      });
    } else {
      // If the user has selected an invalid grade or is older than 100 years
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text("Please enter your birthday and grade to get started", style:TextStyle(color: Colors.white)), 
          backgroundColor: Colors.red,
        )
      );
    }
  }

  var submitting = false;
  var scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      body: Stack(children: <Widget>[
        Container (color: Theme.of(context).backgroundColor, child: Center(child: ListView(shrinkWrap: true, children: <Widget>[
          Padding(child: Column(children: <Widget>[

            Icon(Icons.verified_user, size: 60, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor),
            Divider(color: Colors.transparent, height: 15),
            Text(
              "Hey Chamuth!", 
              textAlign: TextAlign.center, 
              style: TextStyle(fontSize: 25, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor)
            ),
            Divider(color: Colors.transparent, height: 8),
            Text(
              "We need some more information about you to get started", 
              textAlign: TextAlign.center, 
              style: TextStyle(fontSize: 20, color: Colors.grey)
            ),

            Divider(color: Colors.transparent, height: 40),
            
            RawMaterialButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Padding(child: 
              Row(children: <Widget>[
              Icon(Icons.date_range),
              VerticalDivider(),

              Expanded(child: AnimatedCrossFade(firstChild: 
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Text("What is your birthday?", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Tap to select a date", style: TextStyle(color: Colors.grey)),
                ],),
                secondChild:  
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    Text("My Birthday: " + processBirthdayToString(), style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Tap to change your birthday", style: TextStyle(color: Colors.grey)),
                  ],),
                duration: Duration(milliseconds: 500),
                crossFadeState: (selectedDate == null) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              ),),

              AnimatedCrossFade(
                firstChild: Icon(Icons.close, color: Colors.red),
                secondChild: Icon(Icons.done, color: Colors.green),
                duration: Duration(milliseconds: 500),
                crossFadeState: (selectedDate == null) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              ),
              
            ],), padding:  EdgeInsets.fromLTRB(10, 10, 10, 10),), onPressed: () {
              selectBirthday(context);
            },),

            Divider(color: Colors.transparent, height: 20),

            Padding(child: Row(children: <Widget>[
              Icon(Icons.grade),
              VerticalDivider(),

              Expanded(child: 
                Column(children: <Widget>[
                  Align(child: Text("What is your grade?", style: TextStyle(fontWeight: FontWeight.bold)), alignment:Alignment.centerLeft), 
                  DropdownButton(isExpanded: true, isDense: true, icon: (selectedGrade == null) ? Icon(Icons.close, color: Colors.red) : Icon(Icons.done, color: Colors.green), items: grades.map((value) {
                    return new DropdownMenuItem(child: Text(value), value: value);
                  }).toList(), onChanged: (str) { selectedGrade = str; }, value: selectedGrade, hint: Text("Select your grade")),
                ],)
              ),
            ],), padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),


            Divider(color: Colors.transparent, height: 45),

            AnimatedCrossFade(
              secondChild: Column(children: <Widget>[
                Text("You're good to go!", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 17)),
                Divider(color: Colors.transparent, height: 7),
                
                OutlineButton
                (
                  child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Icon(Icons.done, color: Theme.of(context).primaryColor, size: 20),
                    VerticalDivider(width: 5),
                    Text("Get Started", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17)), 
                  ],),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor), 
                  onPressed: () {
                    saveSettings();
                  },
                )
              ],),
              firstChild: Column(children: <Widget>[
                // Icon(Icons.block, color: Colors.red, size: 30,),
                // Divider(color: Colors.transparent, height: 10),
                // Text("Please provide the requested information", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17)),
              ]),
              duration: Duration(milliseconds: 250),
              crossFadeState: (selectedGrade != null && selectedDate != null) ? CrossFadeState.showSecond :  CrossFadeState.showFirst,
            )

          ],), padding: EdgeInsets.fromLTRB(35, 0, 35, 0),)

        ],)),),

        IgnorePointer(ignoring: !submitting, child: 
          AnimatedOpacity(
            child: Container(
              color: Colors.grey[900].withOpacity(0.8), child: Center(child: CircularProgressIndicator())
            ),
            opacity: (submitting) ? 1 : 0, duration: Duration(milliseconds: 250)
          )
        )

      ])
    );
  }
}
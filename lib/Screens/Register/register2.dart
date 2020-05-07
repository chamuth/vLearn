/*
  This part is for teachers registration
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:elearnapp/Screens/start.dart';
import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class Register2Screen extends StatefulWidget {
  Register2Screen({Key key}) : super(key: key);

  @override
  Register2ScreenState createState() => Register2ScreenState();
}

enum Gender { Male, Female }

class Register2ScreenState extends State<Register2Screen> {

  Gender _accType = Gender.Male;
  List<String> subjects = ["Physics (A/L)", "Mathematics (A/L)", "Combined Maths (A/L)", "Chemistry (A/L)", "Information Technology (A/L)", "Biology (A/L)"];
  List<String> filteredSubjects = [];
  List<int> selectedSubjects = [];

  final TextEditingController subjectFilterInput = new TextEditingController();

  @override
  void initState() { 

    setState(() {
      subjects = Organization.me.subjects.map((f) {
        return f.toString();
      }).toList();
    });

    super.initState();
    resetSubjectFilter();
  }

  void resetSubjectFilter()
  {
    setState(() {
      if (subjects.length > 6)
      {
        filteredSubjects = subjects.sublist(0, 6);
      } else {
        filteredSubjects = subjects;
      }
    });
  } 

  void filterSubjects()
  {
    print(subjectFilterInput.text);

    if (subjectFilterInput.text.trim() == "" || subjectFilterInput.text == null)
    {
      resetSubjectFilter();
    } else {
      setState(() {  
        filteredSubjects = subjects.where((f) {
          if (f.toLowerCase().contains(subjectFilterInput.text.toLowerCase()))
            return true;
          
          return false;
        }).toList();

        if (filteredSubjects.length == 0)
          resetSubjectFilter();
      });
    }
  }

  bool submitting = false;

  void saveSettings()
  {
    if (selectedSubjects.length != 0)
    {
      submitting = true;

      Firestore.instance.collection("users").document(User.me.uid).updateData({
        "subjects" : selectedSubjects
      }).then((val) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => StartScreen()),
        );  
      });
      
    } else {
      scaffoldState.currentState.showSnackBar(SnackBar(content: Text("Please select at least one subject", style:TextStyle(color: Colors.white)), backgroundColor: Colors.red,));
    }
  }

  var scaffoldState = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      key: scaffoldState,
      floatingActionButton: FloatingActionButton(tooltip: "Save Subjects", child: Icon(Icons.done), onPressed: ()
      {
        saveSettings();
      },),
      body: Builder(builder: (context) => Stack(children: <Widget>[
        Container(color: (Theme.of(context).backgroundColor), child: Center(child: 
          ListView(shrinkWrap: true, children: <Widget>[
            Padding(child: Column(children: <Widget>[
              Icon(Icons.verified_user, size: 60, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor),
              Divider(color: Colors.transparent, height: 10),
              Text(
                "Hey Chamuth!", 
                textAlign: TextAlign.center, 
                style: TextStyle(fontSize: 25, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor)
              ),
              Divider(color: Colors.transparent, height: 5),
              Text(
                "We need some more information about you to get started", 
                textAlign: TextAlign.center, 
                style: TextStyle(fontSize: 20, color: Colors.grey)
              ),

              Divider(color: Colors.transparent, height: 25),

              Text(
                "Select your subjects",
                style: TextStyle(fontSize: 17)
              ),

              Divider(color: Colors.transparent, height: 15),

              AnimatedCrossFade(firstChild: 
                SizedBox(height: 45, child: Stack(children: <Widget>[

                  ListView(children: List.generate(selectedSubjects.length, (i) {
                    return Padding(child: RawMaterialButton(child: Chip(label: Row(children: <Widget>[
                      Icon(Icons.close, color: Colors.white, size: 20),
                      Padding(child: Text(subjects[selectedSubjects[i]], style: TextStyle(color: Colors.white)), padding: EdgeInsets.fromLTRB(8, 0, 0, 0)),
                    ],)
                    ,backgroundColor: Theme.of(context).primaryColor), onPressed: () {
                      setState(() {
                        selectedSubjects.removeAt(i);
                      });
                    },), padding: EdgeInsets.fromLTRB(0, 0, 5, 0));
                  }), scrollDirection: Axis.horizontal,),

                  IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                          colors: (Themes.darkMode) ? [
                            Theme.of(context).backgroundColor.withOpacity(0.0),
                            Theme.of(context).backgroundColor.withOpacity(1.0),
                          ] : [
                            Theme.of(context).cardColor.withOpacity(0.0),
                            Theme.of(context).cardColor.withOpacity(1.0),
                          ],
                          stops: [0.95, 1.0]
                        )
                      ),
                    ),
                  ignoring: true,)

                ],)
                ),
                secondChild: Column(children: <Widget>[
                  Text("Please select at least one subject", style: TextStyle(color: Colors.grey))
                ],),
                crossFadeState: (selectedSubjects.length > 0) ? CrossFadeState.showFirst : CrossFadeState.showSecond, duration: Duration(milliseconds: 250),
              ),

              Divider(height: 35  ),

              Container(child: TextFormField(decoration: InputDecoration(hintText: "Search for subjects...", border: InputBorder.none,), controller: subjectFilterInput, onChanged: (s) {
                filterSubjects();
              },), decoration: BoxDecoration(color:(Themes.darkMode) ? Colors.grey[700] : Colors.grey[200], borderRadius: BorderRadius.circular(50)), padding: EdgeInsets.fromLTRB(20, 0, 20, 0),),

              Divider(height: 10, color: Colors.transparent),

              Align(child:
              Wrap(spacing: 10, runAlignment: WrapAlignment.center, runSpacing: 0, alignment: WrapAlignment.center, crossAxisAlignment: WrapCrossAlignment.center, children: List.generate(filteredSubjects.length, (index) {
                var subjectIndex = subjects.indexOf(filteredSubjects[index]);
                
                return RawMaterialButton(child: Chip(
                  label: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    if (selectedSubjects.contains(subjectIndex))
                      Icon(Icons.done, color: Colors.white),
                    if (selectedSubjects.contains(subjectIndex))
                      VerticalDivider(width:5, color: Colors.transparent),
                    Text(subjects[subjectIndex], style: TextStyle(color: (selectedSubjects.contains(subjectIndex))? Colors.white : Colors.black)), 
                  ],), backgroundColor: (selectedSubjects.contains(subjectIndex)) ? Theme.of(context).primaryColor : (Themes.darkMode) ? Colors.grey[100] : Colors.grey[300],),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), onPressed: () {
                  

                  if (!selectedSubjects.contains(subjectIndex))
                  {
                    setState(() {
                      print("Adding " + subjects[subjectIndex]);
                      selectedSubjects.add(subjectIndex);
                    });
                  }
                  else 
                  {
                    setState(() {
                      print("Removing " + subjects[subjectIndex]);
                      selectedSubjects.remove(subjectIndex);
                    });
                  }

                }, );

              })), alignment: Alignment.center),

              Divider(height: 10, color: Colors.transparent),

              Text("Note: Search for the subjects in the textbox above to find any subject. Tap to add them to your list.", style: TextStyle(color: Colors.grey)),

              Divider(height: 30, color: Colors.transparent),

            ],), padding: EdgeInsets.fromLTRB(30, 0, 30, 0),)
          ],)
        ,),),

        IgnorePointer(ignoring: !submitting, child: 
          AnimatedOpacity(
            child: Container(
              color: Colors.grey[900].withOpacity(0.8), child: Center(child: CircularProgressIndicator())
            ),
            opacity: (submitting) ? 1 : 0, duration: Duration(milliseconds: 250)
          )
        )

      ]),)
    );
  }
} 
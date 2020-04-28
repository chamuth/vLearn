
import 'package:elearnapp/Themes/themes.dart';
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
  List<int> selectedSubjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      body: Container(color: (Theme.of(context).backgroundColor), child: Center(child: 
        ListView(shrinkWrap: true, children: <Widget>[
          Padding(child: Column(children: <Widget>[
            Icon(Icons.account_circle, size: 60, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor),
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
                  return Padding(child: Chip(label: Text(subjects[selectedSubjects[i]], style: TextStyle(color: Colors.white)), backgroundColor: Theme.of(context).primaryColor), padding: EdgeInsets.fromLTRB(0, 0, 5, 0));
                }), scrollDirection: Axis.horizontal,),

                IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset.centerLeft,
                        end: FractionalOffset.centerRight,
                        colors: [
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

            Divider(height: 15),

            TextFormField(decoration: InputDecoration(hintText: "Search for subjects..."),),

            Divider(height: 10, color: Colors.transparent),

            Align(child:
            Wrap(spacing: 10, crossAxisAlignment: WrapCrossAlignment.center, children: List.generate(subjects.length, (index) {
              return RawMaterialButton(child: Chip(label: Text(subjects[index], style: TextStyle(color: (selectedSubjects.contains(index))? Colors.white : Colors.black)), backgroundColor: (selectedSubjects.contains(index)) ? Theme.of(context).primaryColor : Colors.grey[300],), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), onPressed: () {

                if (!selectedSubjects.contains(index))
                {
                  setState(() {
                    print("Adding " + subjects[index]);
                    selectedSubjects.add(index);
                  });
                }
                else 
                {
                  setState(() {
                    print("Removing " + subjects[index]);
                    selectedSubjects.remove(index);
                  });
                }

              }, );

            })), alignment: Alignment.centerLeft),

          ],), padding: EdgeInsets.fromLTRB(30, 0, 30, 0),)
        ],)
      ,),)  
    );
  }
} 
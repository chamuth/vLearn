import 'package:badges/badges.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class ClassView extends StatefulWidget {
  ClassView({Key key}) : super(key: key);

  @override
  _ClassViewState createState() => _ClassViewState();
}

class ClassAction
{
  IconData actionIcon = Icons.add;
  String actionName = "Sample Action";
  int notificationCount = 0;
  Function onTap;
  
  ClassAction (this.actionIcon, this.actionName, this.notificationCount, this.onTap);
}

class _ClassViewState extends State<ClassView> {

  List<ClassAction> actions = [
    ClassAction(Icons.assignment, "Assignments", 2, () => { }),
    ClassAction(Icons.query_builder, "Questionaires", 2, () => { }),
    ClassAction(Icons.folder_shared, "Class Folder", 0, () => { }),
    ClassAction(Icons.question_answer, "Discussion", 12, () => { }),
    ClassAction(Icons.videocam, "Conference", 0, () => { }),
    ClassAction(Icons.more_horiz, "More", 0, () => { }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.get(context, "English Language - Grade 6"),
      body: Container(child: 
        ListView(children: <Widget>[
          Padding(
            child: Card(
              child: Stack(children: <Widget>[

                Container(
                  height:200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/45593361_526088287868521_6651631862953279488_n.jpg"
                      )
                    )
                  )
                ),

                Container(
                  height:200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Theme.of(context).cardColor.withOpacity(0.65),
                        Theme.of(context).cardColor.withOpacity(1.0),
                      ],
                      stops: [0.0, 1.0]
                    )
                  ),
                ),

                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Row(children: <Widget>[
                        Text("Grade 6", style: TextStyle(fontSize: 16, color: Colors.grey[350], fontWeight: FontWeight.bold)),
                        VerticalDivider(width: 8),
                        Text("·", style: TextStyle(color: Colors.grey[400], fontSize: 20)),
                        VerticalDivider(width: 8),
                        Text("Wisdom International", style: TextStyle(fontSize: 16, color: Colors.grey[350], fontWeight: FontWeight.bold)),
                      ],),
                      Divider(color: Colors.transparent, height: 3),
                      Text("English Language", style: TextStyle(fontSize: 30)),
                      Divider(color: Colors.transparent, height: 7),

                      Row(children: <Widget>[
                        Text("By ", style: TextStyle(fontSize: 17, color: Colors.grey[400], fontWeight: FontWeight.bold)),
                        TouchableOpacity(child: Text("English Man", style: TextStyle(fontSize: 17, color: Colors.grey[100], fontWeight: FontWeight.bold)), onTap: () { 

                        },)
                      ])
                    ])
                  ),

                  Padding(
                    child: GridView.count(shrinkWrap: true, crossAxisCount: 3, children: List.generate(actions.length, (index) {
                      return Padding(child: RawMaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        clipBehavior: Clip.antiAlias,
                        child: Container(color: (Themes.darkMode) ?  Colors.grey[700] : Colors.white.withOpacity(0.85), child: Center(child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
                          if (actions[index].notificationCount > 0)
                            Badge(
                              child: Icon(actions[index].actionIcon, size: 35, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor),
                              badgeContent: Text(actions[index].notificationCount.toString())
                            ),
                          if (actions[index].notificationCount == 0)
                            Icon(actions[index].actionIcon, size: 35, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor),

                          Divider(height: 12, color: Colors.transparent),
                          Text(actions[index].actionName, style: TextStyle(color: (Themes.darkMode) ? Colors.grey[300] : Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize:16))
                        ],))),
                        onPressed: () { actions[index].onTap(); },
                      ), padding: EdgeInsets.all(4));
                    })),
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 7)
                  )

                ]),

              ],) 
              , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), clipBehavior: Clip.antiAlias,
            ), 
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5)
          )
        ],)
      ,),
    );
  }
}
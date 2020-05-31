import 'package:elearnapp/Components/ClassItem.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Screens/Represents/ClassView.dart';
import 'package:elearnapp/Screens/Represents/CreateClassView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:elearnapp/Components/NoticeboardCard.dart';
import 'package:elearnapp/Components/AssignmentsCard.dart';
import 'package:elearnapp/Components/ToDoListCard.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class DashboardTab extends StatefulWidget {
  DashboardTab({Key key}) : super(key: key);

  @override
  DashboardTabState createState() => DashboardTabState();
}

class DashboardTabState extends State<DashboardTab> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(child: SmartRefresher(
      enablePullDown: true,
      header: WaterDropHeader(),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      controller: _refreshController,
      child: ListView(children: <Widget>[
                
        Row(children: <Widget>[ 
          Expanded(flex: 1, child: NoticeboardCard()),
        ],),
        Row(children: <Widget>[
          Expanded(flex: 1, child: AssignmentsCard()),
          Expanded(flex: 1, child: ToDoListCard()),
        ],),

        Seperator(title: (User.me.teacher) ? "Classes hosted by me" : "My Classes"),

        FutureBuilder(
          future: User.getMyClasses(teacher: User.me.teacher),
          builder: (context, results)
          {
            if (results.data != null)
            {
              if (results.data.length > 0)
              {
                return AnimatedCrossFade(
                  duration: Duration(milliseconds: 250), 
                  crossFadeState: (results.connectionState == ConnectionState.done) ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
                  firstChild: Column(children: List.generate(results.data.length, (index) {
                      return TouchableOpacity(child: ClassItem(subject: results.data[index]["subject"], grade: results.data[index]["grade"], hostName: results.data[index]["host"]), onTap: () { 
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => ClassView(classId: results.data[index]["id"])));
                      });
                    }),
                  ),
                  secondChild: Container(
                    child: Center(child: 
                      CircularProgressIndicator()
                    ,), padding: EdgeInsets.fromLTRB(0, 10, 0, 10)
                ));
              } else {
                return Container(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
                  FaIcon(FontAwesomeIcons.frown, size: 45, color: Colors.grey[700]),
                  Divider(color: Colors.transparent, height: 10),
                  Text("You haven't joined any classes", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[500], fontSize: 17)),
                  Divider(color: Colors.transparent, height: 5),
                  Text("Use an invitation link sent by your school to join a class.", style: TextStyle(color: Colors.grey[600], fontSize: 17), textAlign: TextAlign.center,),
                ],), padding: EdgeInsets.fromLTRB(50, 10, 50, 15),);
              }
            } else {
              return Container(
                child: Center(child: 
                  CircularProgressIndicator()
                ,), padding: EdgeInsets.fromLTRB(0, 10, 0, 10)
              );
            }
          }
        ),

        Column(children: <Widget>[
          Padding(child: 
            Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
              if (User.me.teacher)
                Expanded(child: OutlineButton(child: Text("CREATE NEW CLASS"), onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => CreateClassView()));
                },),),
              if (User.me.teacher)
                VerticalDivider(width: 10),
              Expanded(child: OutlineButton(child: Text("VIEW ALL CLASSES"), onPressed: () {},),),
            ],)
          ,padding: EdgeInsets.fromLTRB(10, 10, 10, 10))
        ],),

      ],)
    ), padding: EdgeInsets.fromLTRB(10, 0, 10, 0));
  }
}
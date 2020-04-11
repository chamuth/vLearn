import 'package:elearnapp/Components/ClassItem.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        Seperator(title: "My Classes"),

        Column(children: <Widget>[
          TouchableOpacity(child: ClassItem(subject: "Physics", grade: "Grade 12", hostName: "Mr. John Doe"), onTap: () { }),
          TouchableOpacity(child: ClassItem(subject: "Chemistry", grade: "Grade 12", hostName: "Mr. Jane Doe"), onTap: () { }),
          TouchableOpacity(child: ClassItem(subject: "Combined Mathematics", grade: "Grade 12", hostName: "Mr. Nibarian"), onTap: () { }),
          TouchableOpacity(child: ClassItem(subject: "General English", grade: "Grade 12", hostName: "Mr. English Bro"), onTap: () { }),

          Padding(child: 
            Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
              Expanded(child: OutlineButton(child: Text("VIEW ALL CLASSES"), onPressed: () {},),),
            ],)
          ,padding: EdgeInsets.fromLTRB(10, 10, 10, 0))
        ],),

      ],)
    ), padding: EdgeInsets.fromLTRB(10, 0, 10, 0));
  }
}
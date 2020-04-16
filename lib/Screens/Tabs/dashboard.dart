import 'package:elearnapp/Components/ClassItem.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:elearnapp/Core/User.dart';
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

        FutureBuilder(
          future: User.getMyClasses(),
          builder: (context, results)
          {
            if (results.connectionState == ConnectionState.done) 
            {
              if (results.data.length > 0)
              {
                return ListView.builder(
                  itemCount : results.data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index)
                  {
                    return TouchableOpacity(child: ClassItem(subject: results.data[index]["subject"], grade: results.data[index]["grade"], hostName: results.data[index]["host"]), onTap: () { });
                  },
                );
              } else {
                return Container();
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
              Expanded(child: OutlineButton(child: Text("VIEW ALL CLASSES"), onPressed: () {},),),
            ],)
          ,padding: EdgeInsets.fromLTRB(10, 10, 10, 0))
        ],),

      ],)
    ), padding: EdgeInsets.fromLTRB(10, 0, 10, 0));
  }
}
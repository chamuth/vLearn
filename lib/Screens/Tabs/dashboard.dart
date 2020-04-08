import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class DashboardTab extends StatefulWidget {
  DashboardTab({Key key}) : super(key: key);

  @override
  DashboardTabState createState() => DashboardTabState();
}

class DashboardTabState extends State<DashboardTab> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);


  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: WaterDropHeader(),
      onLoading: () { },
      controller: _refreshController,
      child: Container(
      padding: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        Row(children: <Widget>[
          Expanded(flex: 1, child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(padding: EdgeInsets.fromLTRB(14, 14, 14, 9), child: 
              Column(children: <Widget>[
                Row(children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 13, 0), child: Icon(Icons.developer_board, color: Colors.grey)),
                  Expanded(flex: 1, child: Text("Noticeboard", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[300]))),
                ]),

                Padding(padding: EdgeInsets.fromLTRB(0, 18, 0, 0), child: 
                  SizedBox(
                    height: 100.0,
                    child: ListView(
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: 160.0,
                          color: Colors.grey,
                        ),
                        Container(
                          width: 160.0,
                          color: Colors.blueGrey,
                        ),
                        Container(
                          width: 160.0,
                          color: Colors.grey,
                        ),
                      ],
                    )
                  )
                ),

                Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0), child: Divider()),

                TouchableOpacity(child: Row(children: <Widget>[
                  Expanded(flex:1, child: Text("OPEN NOTICEBOARD", style: TextStyle(fontSize:15, fontWeight: FontWeight.bold))),
                  Icon(Icons.chevron_right),
                ]), activeOpacity: 0.6, onTap: () { },)

              ],)
            ), 
            elevation: 1,)
          ),
        ],)
      ],)
      )
    );
  }
}
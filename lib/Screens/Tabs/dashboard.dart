import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:elearnapp/Components/Noticeboard.dart';
import 'package:elearnapp/Core/NoticeType.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import './../../Components/NoticeItem.dart';

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
    return SmartRefresher(
      enablePullDown: true,
      header: WaterDropHeader(),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      controller: _refreshController,
      child: Container(
      padding: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        Row(children: <Widget>[
          Expanded(flex: 1, child: Noticeboard()),
        ],)
      ],)
      )
    );
  }
}
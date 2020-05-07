import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Components/NoticeboardItemCard.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NoticeboardScreen extends StatefulWidget {
  NoticeboardScreen({Key key}) : super(key: key);

  @override
  _NoticeboardScreenState createState() => _NoticeboardScreenState();
}

class _NoticeboardScreenState extends State<NoticeboardScreen> {

  List<Notice> newNotices = [];
  List<Notice> oldNotices = [];

  @override
  void initState() {
    User.loadNoticeboard(all: true).then((a)
    {
      List<DocumentSnapshot> items = a;
      
      items.forEach((f)
      {
        var notice = Notice();
        notice.title = f.data["title"];
        notice.content = f.data["content"];
        notice.created = (f.data["created"] as Timestamp).toDate();
        notice.status = f.data["status"] ?? "casual";
        notice.author = f.data["author"] ?? "The English Club";

        if (DateTime.now().difference(notice.created).inDays > 30)
        {
          setState(() {
            oldNotices.add(notice);
          });
        } else {
          setState(() {
            newNotices.add(notice);
          });
        }
      });
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.get(context, "Noticeboard", poppable: true),

      body: ListView(shrinkWrap: false, children: <Widget>[
        Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          
          Padding(child: Seperator(title: "Latest Notices",), padding:EdgeInsets.fromLTRB(15, 0, 15, 0)),

          AnimatedCrossFade
          (
            firstChild: Column(mainAxisSize: MainAxisSize.max, children: List.generate(newNotices.length, (i) 
            {
              return NoticeboardItemCard(notice: newNotices[i]);
            })),
            secondChild: Column(children: List.generate(15, (i){
              return Padding(child: Card(child: Padding(
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  VerticalDivider(width: 0),
                  Shimmer.fromColors(child: CircleAvatar(radius: 15, backgroundColor: Theme.of(context).primaryColor,), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]),
                  VerticalDivider(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.3, height: 20),
                    SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 1, height: 35),
                    Row(children: <Widget>[
                      SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.3, height: 18),
                      SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.4, height: 18),
                    ],),
                    SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.2, height: 18),
                  ],)),
                ],), 
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
              )), padding: EdgeInsets.fromLTRB(10, 2, 10, 2),);
            })),
            duration: Duration(milliseconds: 250),
            crossFadeState: (newNotices.length > 0) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),

          if (oldNotices.length > 0)
            Padding(child: Seperator(title: "Archived Notices",), padding:EdgeInsets.fromLTRB(15, 0, 15, 0)),

          if (oldNotices.length > 0)
            Column(mainAxisSize: MainAxisSize.max, children: List.generate(oldNotices.length, (i) 
            {
              return Opacity(child: NoticeboardItemCard(notice: oldNotices[i]), opacity: 0.5);
            })),

        ],)
      ],)
    );
  }
}

class Notice
{
  String title;
  String content;
  DateTime created;
  String status;
  String author;
}
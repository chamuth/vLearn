import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Components/NoticeboardItemCard.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:elearnapp/Components/Shimmer/NoticeboardShimmer.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:flutter/material.dart';

class Notice
{
  String title;
  String content;
  DateTime created;
  String status;
  String author;
}

class NoticeboardScreen extends StatefulWidget {
  NoticeboardScreen({Key key}) : super(key: key);

  @override
  _NoticeboardScreenState createState() => _NoticeboardScreenState();
}

class _NoticeboardScreenState extends State<NoticeboardScreen> {

  List<Notice> newNotices = [];
  List<Notice> oldNotices = [];

  void addNewNotice()
  {
    
  }

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
      floatingActionButton: (User.me.teacher) ? FloatingActionButton(child: Icon(Icons.add), onPressed: addNewNotice,) : null,
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
              return Padding(child: NoticeboardShimmer(), padding: EdgeInsets.fromLTRB(10, 2, 10, 2),);
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

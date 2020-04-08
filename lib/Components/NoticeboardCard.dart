import 'package:elearnapp/Core/NoticeType.dart';
import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import 'NoticeItem.dart';

class NoticeboardCard extends StatefulWidget {
  NoticeboardCard({Key key}) : super(key: key);

  @override
  _NoticeboardCardState createState() => _NoticeboardCardState();
}

class _NoticeboardCardState extends State<NoticeboardCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(padding: EdgeInsets.fromLTRB(14, 14, 0, 9), child: 
          Column(children: <Widget>[
            Row(children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 13, 0), child: Icon(Icons.developer_board, color: Colors.grey)),
              Expanded(flex: 1, child: Text("Noticeboard", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[300]))),
            ]),

            Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0), child: 
              SizedBox(
                height: 55.0,
                child: ListView(
                  
                  // This next line does the trick.
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    NoticeItem(title: "2020 March Assignment", type: NoticeType.assignment, latest: true),
                    NoticeItem(title: "Mechanics sheet", type: NoticeType.text),
                    NoticeItem(title: "GGD Anatomy", type: NoticeType.image),
                  ],
                )
              )
            ),

            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Divider()),

            Padding(child: 
            TouchableOpacity(child: Row(children: <Widget>[
              Expanded(flex:1, child: Text("OPEN NOTICEBOARD", style: TextStyle(fontSize:15, fontWeight: FontWeight.bold))),
              Icon(Icons.chevron_right)
            ]), activeOpacity: 0.6, onTap: () { },),
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0)
            )

          ],)
        ), 
        elevation: 1,
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearnapp/Core/NoticeType.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Screens/Noticeboard/Noticeboard.dart';
import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/cupertino.dart';
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
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 13, 0), child: Icon(Icons.developer_board, color: (Themes.darkMode) ? Colors.grey : Theme.of(context).primaryColor)),
              Expanded(flex: 1, child: Text("Noticeboard", style: TextStyle(fontSize: 20, color: (Themes.darkMode) ? Colors.grey[300] : Theme.of(context).primaryColor, fontWeight: FontWeight.bold))),
            ]),

            Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0), child: 
              FutureBuilder(future: User.loadNoticeboard(), builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null)
                {
                  return Container(padding: EdgeInsets.all(5), child: CircularProgressIndicator());
                } else {
                  return AnimatedCrossFade(crossFadeState: (snapshot.connectionState == ConnectionState.done) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    duration: Duration(milliseconds:250),
                    firstChild: SizedBox(
                      height: 55.0,
                      child: ListView.builder(  
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal, 
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NoticeItem(title: snapshot.data[index]["title"], type: NoticeType.text, latest: (DateTime.now().difference((snapshot.data[index]["created"] as Timestamp).toDate()) < Duration(days: 1)) );
                        },
                      )
                    ),
                    secondChild: Container(padding: EdgeInsets.all(5), child: CircularProgressIndicator()),
                  );
                }
              }, )
            ),

            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Divider()),

            Padding(child: 
            TouchableOpacity(child: Row(children: <Widget>[
              Expanded(flex:1, child: Text("OPEN NOTICEBOARD", style: TextStyle(fontSize:15, fontWeight: FontWeight.bold))),
              Icon(Icons.chevron_right)
            ]), activeOpacity: 0.6, onTap: () { 
              print("HELLO WORLD");
              Navigator.push(context, CupertinoPageRoute(builder: (context) => NoticeboardScreen()));
            },),
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0)
            )

          ],)
        ), 
        elevation: 1,
      ),
    );
  }
}
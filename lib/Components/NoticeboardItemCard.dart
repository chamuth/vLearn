import 'package:elearnapp/Screens/Noticeboard/Noticeboard.dart';
import 'package:faker/faker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:touchable_opacity/touchable_opacity.dart';

class NoticeboardItemCard extends StatefulWidget {
  NoticeboardItemCard({Key key, this.notice}) : super(key: key);

  Notice notice;

  @override
  _NoticeboardItemCardState createState() => _NoticeboardItemCardState();
}

class _NoticeboardItemCardState extends State<NoticeboardItemCard> {

  Widget getNoticeIcon()
  {
    switch (widget.notice.status)
    {
      case "urgent":
        return Icon(Icons.info, color: Colors.red);
        break;
      default: 
        return Icon(Icons.info_outline, color: Colors.grey);
    }
  }

  String ellipsis(String str, int len)
  {
    if (str.length > len) return str.substring(0, len) + "...";
    else return str;
  }

  bool readmore = false;

  @override
  Widget build(BuildContext context) {
    return Padding(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,child: Padding(child: 
      Row(crossAxisAlignment: (widget.notice.content != null) ? CrossAxisAlignment.start : CrossAxisAlignment.center, children: <Widget>[

        getNoticeIcon(),

        VerticalDivider(color: Colors.transparent, width: 10),

        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(widget.notice.title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          Divider(color: Colors.transparent, height: 5),

          if (widget.notice.content != null)
            AnimatedCrossFade(crossFadeState: (!readmore) ? CrossFadeState.showFirst : CrossFadeState.showSecond, duration: Duration(milliseconds: 250), 
              firstChild: 
                RichText(text: TextSpan(children: <TextSpan>[
                  TextSpan(text: ellipsis(widget.notice.content ?? "", 150).trimRight()),
                  TextSpan(text: " "),
                  TextSpan(text: "Read more", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)) 
                ], 
                style: TextStyle(fontSize: 14, fontFamily: "GoogleSans", 
                color: Colors.grey[100]), recognizer: new TapGestureRecognizer()..onTap = () {readmore = true; },),),
              secondChild:
                RichText(text: TextSpan(children: <TextSpan>[
                  TextSpan(text: widget.notice.content ?? ""),
                ], style: TextStyle(fontSize: 14, fontFamily: "GoogleSans", color: Colors.grey[100])),),
            ),

          if (widget.notice.content != null)
            Divider(color: Colors.transparent, height: 10),

          RichText(text: TextSpan(children: <TextSpan>[
            TextSpan(text: "Posted by "),
            TextSpan(text: widget.notice.author, style: TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold)),
            
            TextSpan(text: "\non " +(new DateFormat('dd/MM/yyyy')).format(widget.notice.created)), 
            TextSpan(text: " (" + timeago.format(widget.notice.created) + ")"),

          ], style: TextStyle(fontSize: 12, fontFamily: "GoogleSans", color: Colors.grey[500])),),

          Divider(color: Colors.transparent, height: 2),
          Row(children: <Widget>[
            ButtonTheme(child: OutlineButton(child: Text("Reply to " + widget.notice.author, style:TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold)), 
              highlightedBorderColor: Colors.grey, 
              onPressed: () { },), 
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: BorderSide(width: 2),),),
          ],)
        ],))

      ],),
    padding: EdgeInsets.fromLTRB(12,10,12,8),)), padding: EdgeInsets.fromLTRB(10, 2, 10, 2));
  }
}
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import './../Core/NoticeType.dart';

class NoticeItem extends StatefulWidget {
  
  NoticeItem({
    Key key,
    this.type = NoticeType.file,
    this.title = "March Assignment",
    this.latest = false,
  }) : super(key: key);

  String title;
  NoticeType type;
  bool latest;

  @override
  _NoticeItemState createState() => _NoticeItemState();
}

class _NoticeItemState extends State<NoticeItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[700],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(child: Row(children: <Widget>[
        
        if (widget.type == NoticeType.file)
          Icon(Icons.attach_file, size: 16),
        if (widget.type == NoticeType.image)
          Icon(Icons.photo_filter, size: 16),
        if (widget.type == NoticeType.assignment)
          Icon(Icons.assignment, size: 16),
        if (widget.type == NoticeType.text)
          Icon(Icons.subject, size: 16),

        VerticalDivider(color: Colors.transparent, width: 10,),

        if (!widget.latest)
          Text(widget.title)
        else
          Badge(child: Text(widget.title), position: BadgePosition.topRight(right:-22, top:1),)
      ],), padding: (widget.latest) ? EdgeInsets.fromLTRB(15, 0, 35, 0) : EdgeInsets.fromLTRB(15, 0, 15, 0))
    );
  }
}
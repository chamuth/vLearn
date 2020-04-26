import 'package:flutter/material.dart';

class ProfileDetailItem extends StatefulWidget {
  ProfileDetailItem({Key key, this.icon, this.prop, this.val}) : super(key: key);

  IconData icon = Icons.home;
  String prop = "Lives in";
  String val = "Kegalle";

  @override
  _ProfileDetailItemState createState() => _ProfileDetailItemState();
}

class _ProfileDetailItemState extends State<ProfileDetailItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Row(children: <Widget>[
        Icon(widget.icon),
        VerticalDivider(color: Colors.transparent),
        Expanded(child: Wrap(children: <Widget>[
          Text(widget.prop, style: TextStyle(fontSize: 16)),
          Text(widget.val, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],))
      ],),
      padding: EdgeInsets.fromLTRB(30, 3, 30, 7)
    );
  }
}
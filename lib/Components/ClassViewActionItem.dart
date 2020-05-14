import 'package:badges/badges.dart';
import 'package:elearnapp/Core/Classes.dart';
import 'package:elearnapp/Screens/Represents/ClassView.dart';
import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/material.dart';

class ActionItem extends StatefulWidget {
  ActionItem({Key key, this.actions, this.index, this.size}) : super(key: key);

  List<ClassAction> actions;
  int index;
  int size = 3;

  @override
  ActionItemState createState() => ActionItemState();
}

class ActionItemState extends State<ActionItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(child: RawMaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: Container(color: (Themes.darkMode) ?  Colors.grey[700].withOpacity(0.9) : Colors.white.withOpacity(0.85), child: Center(child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
        if (widget.actions[widget.index].notificationCount > 0)
          Badge(
            child: Icon(widget.actions[widget.index].actionIcon, size: (widget.size == 3) ? 35 : 25, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor),
            badgeContent: Text(widget.actions[widget.index].notificationCount.toString())
          ),
        if (widget.actions[widget.index].notificationCount == 0)
          Icon(widget.actions[widget.index].actionIcon, size: (widget.size == 3) ? 35 : 25, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor),

        Divider(height: (widget.size == 3) ? 12 : 7, color: Colors.transparent),
        Text(widget.actions[widget.index].actionName, style: TextStyle(color: (Themes.darkMode) ? Colors.grey[300] : Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize:(widget.size == 3) ? 16 : 14))
      ],))),
      onPressed: () { widget.actions[widget.index].onTap(); },

    ), padding: EdgeInsets.all(4));
  }
}
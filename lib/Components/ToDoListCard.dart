import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class ToDoListCard extends StatefulWidget {
  ToDoListCard({Key key}) : super(key: key);

  @override
  _ToDoListCardState createState() => _ToDoListCardState();
}

class _ToDoListCardState extends State<ToDoListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(padding: EdgeInsets.fromLTRB(14, 14, 14, 9), child: 
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Row(children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 13, 0), child: Icon(Icons.list, color: (Themes.darkMode) ? Colors.grey : Theme.of(context).primaryColor)),
              FutureBuilder(builder: (context, result) {

                return AnimatedCrossFade(
                  duration: Duration(milliseconds: 250),
                  crossFadeState: (result.connectionState == ConnectionState.done) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  firstChild: Text(result?.data ?? "0", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: (Themes.darkMode) ? Colors.grey[300] : Theme.of(context).primaryColor)),
                  secondChild: SizedBox(child: CircularProgressIndicator( strokeWidth: 2,), width:15, height: 15),
                );

              }, future: User.getMyTodoCount())
            ]),

            Padding(child: Text("To Do List", textAlign: TextAlign.left, style: TextStyle(fontSize:18, color: Colors.grey[500], fontWeight: FontWeight.bold)), padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),

            Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Divider()),

            Padding(child: 
            TouchableOpacity(child: Row(children: <Widget>[
              Expanded(flex:1, child: Text("SHOW ALL", style: TextStyle(fontSize:15, fontWeight: FontWeight.bold))),
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
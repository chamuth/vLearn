import 'package:elearnapp/Core/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';

class LoadedProfileViewCard extends StatefulWidget {
  LoadedProfileViewCard({Key key, this.user}) : super(key: key);

  User user;

  @override
  _LoadedProfileViewCardState createState() => _LoadedProfileViewCardState();
}

class _LoadedProfileViewCardState extends State<LoadedProfileViewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), clipBehavior: Clip.antiAlias, 
      child: Stack(children: <Widget>[
        Container(
          height: 175,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/IMG_20191002_150704.jpg"), fit: BoxFit.cover)),
        ),

        Container(
          height: 175,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Theme.of(context).cardColor.withOpacity(0.2),
                Theme.of(context).cardColor.withOpacity(1),
              ],
              stops: [0.0, 1.0]
            )
          ),
        ),

        Positioned(width: MediaQuery.of(context).size.width - 20,child: Padding(child: Row(children: <Widget>[

          CircleAvatar(child: Text("C", style: TextStyle(color: Colors.white, fontSize: 20),), radius: 25, backgroundColor: Theme.of(context).primaryColor),
          
          VerticalDivider(color: Colors.transparent, width: 12),

          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(User.getSanitizedName(widget.user), style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            Divider(color: Colors.transparent, height: 3),
            Text("Science (Mathematics)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[300])),
            Divider(color: Colors.transparent, height: 1),
            BreadCrumb(items: [
              BreadCrumbItem(content: 
                Text("Student", style: TextStyle(fontSize: 16, color: Colors.grey)),
              ),
              BreadCrumbItem(content: 
                Text("Grade 12", style: TextStyle(fontSize: 16, color: Colors.grey)),
              ),
              ], divider: Padding(padding: EdgeInsets.fromLTRB(2, 0, 2, 0), child: Text(" · ", style: TextStyle(fontSize: 18, color : Colors.grey)),)
            )
          ],),),

          IconButton(icon: Icon(Icons.more_vert), color: Colors.white, onPressed: () {

          },)


        ],), padding: EdgeInsets.fromLTRB(15, 15, 15, 15),), bottom:0)
      ],),
    );
  }
}
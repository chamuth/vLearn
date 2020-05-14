import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearnapp/Core/Classes.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:elearnapp/Screens/Represents/ClassView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';

import 'ClassViewActionItem.dart';

class LoadedProfileViewCard extends StatefulWidget {
  LoadedProfileViewCard({Key key, this.user}) : super(key: key);

  User user;

  @override
  _LoadedProfileViewCardState createState() => _LoadedProfileViewCardState();
}

class _LoadedProfileViewCardState extends State<LoadedProfileViewCard> {

  List<ClassAction> actions = [
    ClassAction(Icons.question_answer, "Message", 0, () {}),
    ClassAction(Icons.call, "Call", 0, () {}),
    ClassAction(Icons.block, "Block", 0, () {}),
    ClassAction(Icons.report, "Report", 0, () {})
  ];

  String profilePictureUrl = "";
  String coverPictureUrl = "";

  @override
  void initState() {

    if (widget.user.profilePicture)
      User.getProfilePicture(widget.user.uid).then((val) {
        setState(() {
          profilePictureUrl = val;
        });
      });

    if (widget.user.coverPicture)
      User.getCoverPicture(widget.user.uid).then((val) {
        setState(() {
          coverPictureUrl = val;
        });
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), clipBehavior: Clip.antiAlias, 
      child: Stack(children: <Widget>[

        if (coverPictureUrl != null && coverPictureUrl != "")
          CachedNetworkImage(imageBuilder : (context, provider) {
            return Container(
              height: 175,
              decoration: BoxDecoration(image: DecorationImage(image: provider, fit: BoxFit.cover)),
            );
          }, imageUrl: coverPictureUrl,),

        if (!widget.user.coverPicture)
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

        Column(children: <Widget>[

          Padding(child: Row(children: <Widget>[
            
            if (profilePictureUrl != null && profilePictureUrl != "")
              CachedNetworkImage(imageUrl: profilePictureUrl, imageBuilder: (context, provider) {
                return CircleAvatar(
                  backgroundImage: provider,
                  radius: 25,
                  backgroundColor: Theme.of(context).primaryColor
                );
              }),
            
            if (profilePictureUrl == "")
              CircleAvatar(child: Text(widget.user.firstName.substring(0,1).toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 20),),
                radius: 25,
                backgroundColor: Theme.of(context).primaryColor
              ),
            
            VerticalDivider(color: Colors.transparent, width: 12),

            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text(User.getSanitizedName(widget.user), style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              Divider(color: Colors.transparent, height: 3),
              Text("Junior Section", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[300])),
              Divider(color: Colors.transparent, height: 1),
              BreadCrumb(items: [
                BreadCrumbItem(content: 
                  Text((widget.user.teacher) ? "Teacher" : "Student", style: TextStyle(fontSize: 16, color: Colors.grey)),
                ),
                BreadCrumbItem(content: 
                  Text(Organization.me.grades[widget.user.grade], style: TextStyle(fontSize: 16, color: Colors.grey)),
                ),
                ], divider: Padding(padding: EdgeInsets.fromLTRB(2, 0, 2, 0), child: Text(" · ", style: TextStyle(fontSize: 18, color : Colors.grey)),)
              )
            ],),),

            IconButton(icon: Icon(Icons.more_vert), color: Colors.white, onPressed: () {

            },)

          ],), padding: EdgeInsets.fromLTRB(15, 100, 0, 15),),

          Padding(
            child: GridView.count(shrinkWrap: true, crossAxisCount: 4, children: List.generate(actions.length, (index) {
              return ActionItem(actions: actions, index: index, size: 4);
            })),
            padding: EdgeInsets.fromLTRB(5, 5, 5, 7)
          ),

        ],)

      ],),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearnapp/Components/ClassViewActionItem.dart';
import 'package:elearnapp/Components/LatestActivityItem.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:elearnapp/Core/Classes.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ClassAction
{
  IconData actionIcon = Icons.add;
  String actionName = "Sample Action";
  int notificationCount = 0;
  Function onTap;
  
  ClassAction (this.actionIcon, this.actionName, this.notificationCount, this.onTap);
}

class ClassView extends StatefulWidget {
  ClassView({Key key}) : super(key: key);

  @override
  _ClassViewState createState() => _ClassViewState();
}

class _ClassViewState extends State<ClassView> {

  ClassData data = ClassData("", "", "");
  User host = User.fromName("", "");
  bool classDataLoaded = false;
  int activitySize = -1;
  String backdropImageURL = "";

  List<ClassAction> actions = [
    ClassAction(Icons.assignment, "Assignments", 2, () => { }),
    ClassAction(Icons.query_builder, "Questionaires", 2, () => { }),
    ClassAction(Icons.folder_shared, "Class Folder", 0, () => { }),
    ClassAction(Icons.question_answer, "Discussion", 12, () => { }),
    ClassAction(Icons.videocam, "Conference", 0, () => { }),
    ClassAction(Icons.more_horiz, "More", 0, () => { }),
  ];

  void loadClass() async
  {
    var classID = ModalRoute.of(context).settings.arguments;
    var temp = await ClassData.getClass(classID);
    var tempHost = await User.getUser(temp.host);

    var ref = FirebaseStorage.instance.ref().child("organizations").child(Organization.currentOrganizationId).child("class_backdrops").child(classID.toString() + ".jpg");
    var url = await ref.getDownloadURL();

    if (mounted)
    {
      setState(() {
        host = tempHost;
        data = temp;
        backdropImageURL = url.toString();

        classDataLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loadClass();
  
    return Scaffold(
      appBar: MainAppBar.get(context, (data.subject == "") ? "Loading..." : data.subject + " - " + data.grade, poppable: true),
      body: Container(child: 
        ListView(children: <Widget>[
          AnimatedCrossFade(duration: Duration(milliseconds: 250), crossFadeState: (classDataLoaded) ? CrossFadeState.showFirst : CrossFadeState.showSecond, firstChild: 
            Padding(
              child: Card(
                child: Stack(children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: backdropImageURL,
                    imageBuilder: (context, imageProvider) => Container(
                      height:200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageProvider
                        )
                      )  
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  
                  Container(
                    height:200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Theme.of(context).cardColor.withOpacity(0.65),
                          Theme.of(context).cardColor.withOpacity(1.0),
                        ],
                        stops: [0.0, 1.0]
                      )
                    ),
                  ),

                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Row(children: <Widget>[
                          Text(data.grade, style: TextStyle(fontSize: 16, color: Colors.grey[350], fontWeight: FontWeight.bold)),
                          VerticalDivider(width: 8),
                          Text("·", style: TextStyle(color: Colors.grey[400], fontSize: 20)),
                          VerticalDivider(width: 8),
                          Text(Organization.me.name, style: TextStyle(fontSize: 16, color: Colors.grey[350], fontWeight: FontWeight.bold)),
                        ],),
                        Divider(color: Colors.transparent, height: 3),
                        Text(data.subject, style: TextStyle(fontSize: 30)),
                        Divider(color: Colors.transparent, height: 7),

                        Row(children: <Widget>[
                          Text("By ", style: TextStyle(fontSize: 17, color: Colors.grey[400], fontWeight: FontWeight.bold)),
                          Text(User.getSanitizedName(host), style: TextStyle(fontSize: 17, color: Colors.grey[100], fontWeight: FontWeight.bold))
                        ])
                      ])
                    ),

                    Padding(
                      child: GridView.count(shrinkWrap: true, crossAxisCount: 3, children: List.generate(actions.length, (index) {
                        return ActionItem(actions: actions, index: index);
                      })),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 7)
                    ),

                  ]),

                ],) 
                , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), clipBehavior: Clip.antiAlias,
              ), 
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5)
            ), 
            secondChild: Padding(child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250.0,
              child: Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor,
                highlightColor: Colors.grey[500],
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), clipBehavior: Clip.antiAlias,
                )
              ),
            ), padding: EdgeInsets.fromLTRB(10, 5, 10, 5))
          ),
          // LATEST ACTIVITY FEED
          Padding(child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
            Seperator(title: "LATEST ACTIVITY"),
          ],), padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
          
          // LATEST ACTIVITY
          AnimatedCrossFade(duration: Duration(milliseconds: 250), crossFadeState: (activitySize != 0) ? CrossFadeState.showFirst : CrossFadeState.showSecond, firstChild: 
            Column(children: List.generate(5, (index){
              return Padding(child: Row(children: <Widget>[
                Expanded(child: 
                  AnimatedCrossFade(duration: Duration(milliseconds: 250), crossFadeState: (classDataLoaded) ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
                    firstChild: LatestActivityItem(person: User.fromName("Chamuth", "Chamandana"), actionType: ActionTypes.comment, target: "January Assignment 2020",),
                    secondChild:  Card(child: Padding(
                      child: Row(children: <Widget>[
                        Shimmer.fromColors(child: CircleAvatar(radius: 18, backgroundColor: Theme.of(context).primaryColor,), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]),
                        VerticalDivider(),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                          SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.3, height: 20),
                          SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.5, height: 20)
                        ],)),
                        Shimmer.fromColors(child: CircleAvatar(radius: 12, backgroundColor: Theme.of(context).primaryColor,), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]),
                        VerticalDivider(width:10),
                      ],), 
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
                    ))
                  ),
                )
              ]), padding: EdgeInsets.fromLTRB(10, 0, 10, 0));
            })),

            secondChild: Column(children: <Widget>[
              Divider(height:25, color: Colors.transparent),
              Icon(Icons.timer_off, size: 50, color: Colors.grey),
              Divider(height:15, color: Colors.transparent),
              Text("No activity in this class", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 18))
            ],)
          )

        ],)
      ,),
    );
  }
}
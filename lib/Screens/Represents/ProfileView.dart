import 'package:elearnapp/Components/ClassItem.dart';
import 'package:elearnapp/Components/LoadedProfileViewCard.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Components/ProfileDetailItem.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:shimmer/shimmer.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key key, this.uid}) : super(key: key);
  String uid;
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  bool profileLoaded = false;
  User user = User.fromName("", "");
  
  @override
  void initState() {
    User.getUser(widget.uid).then((val) {
      setState(() {
        user = val;
      });

      setState(() {
        profileLoaded = true;
      });
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.get(context, User.getSanitizedName(user), poppable: true ),
      body: Container(child: 
        ListView(children: <Widget>[

          AnimatedCrossFade(
            firstChild: Padding(
              child: LoadedProfileViewCard(user: user),
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            ),
            secondChild: Padding(
              child: Card(child: Container(height: 150, child: Stack(children: <Widget>[
                Positioned(width: MediaQuery.of(context).size.width - 30,child: Padding(child: Row(children: <Widget>[

                  Shimmer.fromColors(child: CircleAvatar(radius: 25, backgroundColor: Theme.of(context).primaryColor,), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]),
                  
                  VerticalDivider(color: Colors.transparent, width: 12),

                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.5, height: 20),
                    SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.4, height: 20),
                    BreadCrumb(items: [
                      BreadCrumbItem(content: 
                        SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: 55, height: 20),
                      ),
                      BreadCrumbItem(content: 
                        SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: 45, height: 20),
                      ),
                      ], divider: Padding(padding: EdgeInsets.fromLTRB(2, 0, 2, 0), child: Text(" · ", style: TextStyle(fontSize: 18, color : Colors.grey)),)
                    )
                  ],),),

                  Shimmer.fromColors(child: CircleAvatar(radius: 14, backgroundColor: Theme.of(context).primaryColor,), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]),

                ],), padding: EdgeInsets.fromLTRB(15, 15, 15, 15),), bottom:0)

              ],),)),
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            ),
            crossFadeState: (profileLoaded) ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
            duration: Duration(milliseconds: 250)
          ),

          if (!user.teacher)
            Column(children: <Widget>[

              Padding(child: Seperator(title: "Joined Classes"), padding: EdgeInsets.fromLTRB(15, 0, 15, 0)),

              // todo: load the classes here
              if (true)
                Padding(
                  child: Column(children: List.generate(1, (index) {
                    return ClassItem(subject: "Combined Mathematics", grade: "Grade 12", hostName: "Maths Nigga");
                  }),), 
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0)
                ),
              if (false)
                Padding(
                  child: Column(children: <Widget>[
                    Divider(height:10, color: Colors.transparent),
                    Icon(Icons.timer_off, size: 50, color: Colors.grey),
                    Divider(height:15, color: Colors.transparent),
                    Text("User hasn't joined any classes", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 18))
                  ],),
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 25)
                ),

            ],),

          if (user.teacher)
            Column(children: <Widget>[
              
              Padding(child: Seperator(title: "Currently Teaching"), padding: EdgeInsets.fromLTRB(15, 0, 15, 0)),

              Wrap(spacing: 10, runSpacing: 0, alignment: WrapAlignment.center,  children: <Widget>[
                Chip(label: Text("Physics"), backgroundColor: Theme.of(context).primaryColor,),
                Chip(label: Text("Combined Mathematics"), backgroundColor: Theme.of(context).primaryColor,),
                Chip(label: Text("Chemistry"), backgroundColor: Theme.of(context).primaryColor,),
              ],),

              Padding(child: Seperator(title: "Hosted Classes"), padding: EdgeInsets.fromLTRB(15, 0, 15, 0)),

              Padding(
                child: Column(children: List.generate(1, (index) {
                  return ClassItem(subject: "Combined Mathematics", grade: "Grade 12", hostName: "Maths Nigga");
                }),), 
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0)
              ),
              
            ],),  

          Padding(child: Seperator(title: "About " + User.getSanitizedName(user)), padding: EdgeInsets.fromLTRB(15, 0, 15, 0)),

          ProfileDetailItem(icon: Icons.school, prop: "Studying at ", val: "Pinnawala Central College",),
          ProfileDetailItem(icon: Icons.home, prop: "Lives in ", val: "Kegalle",),

        ],
      ),),
    );
  }
}
import 'package:elearnapp/Components/ClassItem.dart';
import 'package:elearnapp/Components/LoadedProfileViewCard.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Components/ProfileDetailItem.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:elearnapp/Screens/Represents/ClassView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key key, this.uid}) : super(key: key);
  
  final String uid;
  
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  bool profileLoaded = false;
  User user = User.fromName("", "");

  List<String> mySubjects = [];
  
  @override
  void initState() {
    User.getUser(widget.uid).then((val) {

      // get user subjects 
      val.subjects.forEach((f) {
        mySubjects.add(Organization.me.subjects[f].toString());
      });

      User.getMyClasses(uid: widget.uid).then((classes) {
        setState(() {
          joinedClasses = classes;
          user = val;
          profileLoaded = true;
        });
      });

    });
    
    super.initState();
  }

  List joinedClasses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.get(context, User.getSanitizedName(user), poppable: true ),
      body: Container(child: 
        ListView(children: <Widget>[

          AnimatedCrossFade(
            firstChild: Padding(
              child: (profileLoaded) ? LoadedProfileViewCard(user: user) : Container(),
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

              if (!profileLoaded)
                Container(child: Center(child: CircularProgressIndicator()), padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              
              if (profileLoaded)
                if (joinedClasses.length > 0)
                  Padding(child: Column(children: List.generate(joinedClasses.length, (i)
                  {
                    return TouchableOpacity(child: ClassItem(subject: joinedClasses[i]["subject"], grade: joinedClasses[i]["grade"], hostName: joinedClasses[i]["host"]), onTap: () { 
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => ClassView(classId: joinedClasses[i]["id"])));
                    });
                  }),), padding: EdgeInsets.fromLTRB(10, 0, 10, 0),),
              if (profileLoaded)
                if (joinedClasses.length == 0)
                  Container(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
                    FaIcon(FontAwesomeIcons.frown, size: 45, color: Colors.grey[700]),
                    Divider(color: Colors.transparent, height: 10),
                    Text(user.firstName + " hasn't joined any classes", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[500], fontSize: 17)),
                    Divider(color: Colors.transparent, height: 5),
                    Text("Use an invitation link sent by your school to join a class.", style: TextStyle(color: Colors.grey[600], fontSize: 17), textAlign: TextAlign.center,),
                  ],), padding: EdgeInsets.fromLTRB(50, 10, 50, 15),),

            ],),

          if (user.teacher)
            Column(children: <Widget>[
              
              Padding(child: Seperator(title: "Currently Teaching"), padding: EdgeInsets.fromLTRB(15, 0, 15, 0)),

              Wrap(spacing: 10, runSpacing: 0, alignment: WrapAlignment.center,  children: mySubjects.map((f) {
                return Chip(label: Text(f), backgroundColor: Theme.of(context).primaryColor,);
              }).toList()),

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
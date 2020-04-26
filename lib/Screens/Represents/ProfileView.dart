import 'package:elearnapp/Components/ClassItem.dart';
import 'package:elearnapp/Components/LoadedProfileViewCard.dart';
import 'package:elearnapp/Components/MainAppBar.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:shimmer/shimmer.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  bool profileLoaded = false;

  @override
  void initState() {
    
    Future.delayed(Duration(seconds: 5), (){
      setState(() {
        profileLoaded = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.get(context, "Chamuth Chamandana"),
      body: Container(child: 
        ListView(children: <Widget>[

          AnimatedCrossFade(
            firstChild: Padding(
              child: LoadedProfileViewCard(user: User.fromName("Chamuth", "Chamandana")),
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            ),
            secondChild: Padding(
              child: Card(child: Container(height: 90, child: Stack(children: <Widget>[
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

          Padding(child: Seperator(title: "Joined Classes"), padding: EdgeInsets.fromLTRB(15, 0, 15, 0)),

          Padding(
            child: Column(children: List.generate(3, (index) {
              return ClassItem(subject: "Combined Mathematics", grade: "Grade 12", hostName: "NIBRO");
            }),), 
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0)
          ),
        ],
      ),),
    );
  }
}
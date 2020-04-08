import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({Key key}) : super(key: key);

  @override
  ProfileTabState createState() => ProfileTabState();
}

class ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("Profile"),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsTab extends StatefulWidget {
  SettingsTab({Key key}) : super(key: key);

  @override
  SettingsTabState createState() => SettingsTabState();
}

class SettingsTabState extends State<SettingsTab> {

  void logout()
  {
    Fluttertoast.showToast(
      msg: "Please wait...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0
    );

    // log out of your account
    FirebaseAuth.instance.signOut().then((res) {
      Navigator.pushReplacementNamed(context, "/login");
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
       children: <Widget>[
         RawMaterialButton(child: Padding(child: Row(children: <Widget>[
           Padding(child: Icon(Icons.exit_to_app, size:25, color: Colors.grey[400]), padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
           Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
             Padding(child: Text("Log out", style: TextStyle(fontSize:18, fontWeight:FontWeight.bold)), padding: EdgeInsets.fromLTRB(0, 0, 0, 2)),
             Text("from c.chamandana@gmail.com", style: TextStyle(fontSize:17, color: Colors.grey)),
           ],))
         ],), padding: EdgeInsets.fromLTRB(25, 15, 25, 15)), onPressed: () {
           logout();
         },)
       ],
    );
  }
}
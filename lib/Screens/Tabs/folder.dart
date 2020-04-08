import 'package:flutter/material.dart';

class FolderTab extends StatefulWidget {
  FolderTab({Key key}) : super(key: key);

  @override
  FolderTabState createState() => FolderTabState();
}

class FolderTabState extends State<FolderTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("FOLDER"),
    );
  }
}
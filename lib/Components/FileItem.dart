import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/material.dart';

enum FileItemType 
{
  classItem, folderItem, fileItem
}

class FileItem extends StatefulWidget {
  FileItemType type;
  String filename;
  FileItem({Key key, this.type = FileItemType.classItem, this.filename = "Class"}) : super(key: key); 

  @override
  _FileItemState createState() => _FileItemState();
}

class _FileItemState extends State<FileItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: <Widget>[
        Expanded(flex:1, child: 
          Padding(child: Icon(Icons.class_, size:70, color:(Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor), padding: EdgeInsets.fromLTRB(0, 25, 0, 0))
        ,),
        Padding(padding: EdgeInsets.all(12), child: 
          Row(children: <Widget>[
            Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
              Padding(child: Text("Physics", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor)), padding: EdgeInsets.fromLTRB(0, 0, 0, 3)),
              Text("Grade 12", style: TextStyle(color: Colors.grey)),
            ],)
            
          ],)
        )
      ],)
    );
  }
}
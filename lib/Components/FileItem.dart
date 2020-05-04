import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/material.dart';

enum FileItemType 
{
  classItem, folderItem, fileItem
}

class FileItem extends StatefulWidget {
  FileItemType type;
  Function onPressed; 
  String title;
  String subtitle;
  FileItem({Key key, this.type = FileItemType.classItem, this.title = "Class", this.subtitle = "Grade 12", this.onPressed}) : super(key: key); 

  @override
  _FileItemState createState() => _FileItemState();
}

class _FileItemState extends State<FileItem> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(child: Card(
      child: Column(children: <Widget>[
        Expanded(flex:1, child: 
          Padding(
            child: (widget.type == FileItemType.classItem) 
            ? Icon(Icons.class_, size:70, color:(Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor)
            : (widget.type == FileItemType.folderItem) ? 
              Icon(Icons.folder, size:70, color:(Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor) : 
              Icon(Icons.image, size:70, color:(Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor), 
            padding: EdgeInsets.fromLTRB(0, 25, 0, 0)
          )
        ,),
        Padding(padding: EdgeInsets.all(12), child: 
          Row(children: <Widget>[
            Expanded(child: 
              Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                Text(widget.title, overflow: TextOverflow.fade, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor)),
                Divider(color: Colors.transparent, height: 3),
                Text(widget.subtitle, style: TextStyle(color: Colors.grey)),
              ],)
            )
          ],)
        )
      ],)
    ), onPressed: () { widget.onPressed(); });
  }
}
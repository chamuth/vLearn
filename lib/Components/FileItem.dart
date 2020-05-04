import 'package:elearnapp/Themes/themes.dart';
import 'package:flutter/material.dart';

enum FileItemType 
{
  classItem, folderItem, fileItem, imageItem, 
}

class FileItem extends StatefulWidget {
  FileItemType type;
  Function onPressed; 
  String title;
  String filename;
  String subtitle;
  String thumbnailUri;

  FileItem({Key key, this.type = FileItemType.classItem, this.filename, this.thumbnailUri, this.title = "Class", this.subtitle = "Grade 12", this.onPressed}) : super(key: key); 

  @override
  _FileItemState createState() => _FileItemState();
}

class _FileItemState extends State<FileItem> {

  IconData getIconForType(FileItemType type)
  {
    switch (type) 
    {
      case FileItemType.classItem:
        return Icons.class_;
      case FileItemType.folderItem:
        return Icons.folder;
      case FileItemType.fileItem:
        return Icons.insert_drive_file;
      case FileItemType.imageItem:
        return Icons.image;
      default: 
        return Icons.class_;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(child: Card(
      child: Column(children: <Widget>[
        Expanded(flex:1, child: 
          Padding(
            child: Icon(getIconForType(widget.type), size:70, color:(Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor), 
            padding: EdgeInsets.fromLTRB(0, 25, 0, 0)
          )
        ,),
        Padding(padding: EdgeInsets.all(12), child: 
          Row(children: <Widget>[
            if (widget.type == FileItemType.classItem)
              Expanded(child: 
                Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                  Text(widget.title, overflow: TextOverflow.fade, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor)),
                  Divider(color: Colors.transparent, height: 3),
                  Text(widget.subtitle, style: TextStyle(color: Colors.grey)),
                ],)
              ),
            if (widget.type != FileItemType.classItem)
              if (widget.type == FileItemType.folderItem)
                Expanded(child: 
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                    Text(widget.subtitle, style: TextStyle(color: Colors.grey)),
                    Divider(color: Colors.transparent, height: 2),
                    Text(widget.title, overflow: TextOverflow.fade, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor)),
                  ],)
                ),
              if (widget.type == FileItemType.imageItem)
                Expanded(child: 
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                    
                    
                    Text(widget.title, overflow: TextOverflow.fade, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor)),
                  ],)
                ),
          ],)
        )
      ],)
    ), onPressed: () { widget.onPressed(); });
  }
}
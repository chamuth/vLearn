import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearnapp/Core/Ellipsis.dart';
import 'package:elearnapp/Core/Preferences.dart';
import 'package:elearnapp/Themes/themes.dart';
import 'package:filesize/filesize.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
  int size;

  FileItem({Key key, this.size, this.type = FileItemType.classItem, this.filename, this.thumbnailUri, this.title = "Class", this.subtitle = "Grade 12", this.onPressed}) : super(key: key); 

  @override
  _FileItemState createState() => _FileItemState();
}

class _FileItemState extends State<FileItem> {

  String thumbnailDownloadUrl = "";

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

  void loadThumbnails() async
  {
    if (widget.type == FileItemType.imageItem)
    {
      // get download link for thumbnail
      var temp = await FirebaseStorage.instance.ref().child(widget.filename).getDownloadURL();      

      if (mounted)
        setState(() {
          thumbnailDownloadUrl = temp;
        });
    }
  }

  @override
  void initState() {
    loadThumbnails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(child: Card(
      child: Column(children: <Widget>[
        if (widget.type != FileItemType.imageItem)
          Expanded(flex:1, child: 
            Padding(
              child: Icon(getIconForType(widget.type), size:70, color:(Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor), 
              padding: EdgeInsets.fromLTRB(0, 25, 0, 0)
            )
          ,),
        if (widget.type == FileItemType.imageItem)
          Expanded(
            flex: 1, 
            child: AnimatedCrossFade(crossFadeState: (thumbnailDownloadUrl == "") ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
            firstChild: Align(child: CircularProgressIndicator(), alignment: Alignment.center), 
            secondChild: CachedNetworkImage(
              imageUrl: thumbnailDownloadUrl,
              imageBuilder: (context, imageProvider) => Container(

                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProvider
                  )
                )  
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ), duration: Duration(milliseconds: 300),
          )
        ),
          
        Padding(padding: EdgeInsets.fromLTRB(10, 5, 10, 8), child: 
          Row(children: <Widget>[
            if (widget.type == FileItemType.classItem)
              Expanded(child: 
                Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                  Text(ellipsis(widget.title, 25), overflow: TextOverflow.fade, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor)),
                  Divider(color: Colors.transparent, height: 3),
                  Text(widget.subtitle, style: TextStyle(color: Colors.grey)),
                ],)
              ),
            if (widget.type != FileItemType.classItem)
              if (widget.type == FileItemType.folderItem)
                Expanded(child: 
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                    Text(ellipsis(widget.subtitle, 25), style: TextStyle(color: Colors.grey)),
                    Divider(color: Colors.transparent, height: 2),
                    Text(ellipsis(widget.title, 25), overflow: TextOverflow.fade, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor)),
                  ],)
                ),
              if (widget.type == FileItemType.imageItem)
                Expanded(child: 
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[                    
                    Text(ellipsis(widget.title, 25), overflow: TextOverflow.fade, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor)),
                    Divider(color: Colors.transparent, height: 2),
                    Text(ellipsis(filesize(widget.size), 25), style: TextStyle(color: Colors.grey)),
                  ],)
                ),
              if (widget.type == FileItemType.fileItem)
                Expanded(child: 
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                    Text(ellipsis(widget.title, 25), overflow: TextOverflow.fade, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: (Themes.darkMode) ? Colors.white : Theme.of(context).primaryColor)),
                    Divider(color: Colors.transparent, height: 2),
                    Text(ellipsis(filesize(widget.size), 25), style: TextStyle(color: Colors.grey)),
                  ],)
                ),
          ],)
        )
      ],)
    ), onPressed: () { 
      if (widget.type == FileItemType.imageItem)
      {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => Container(child: 
            CachedNetworkImage(
              imageUrl: thumbnailDownloadUrl,
              imageBuilder: (context, imageProvider) => PhotoView(imageProvider: imageProvider),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          )),
        );
      } else {
        widget.onPressed(); 
      }
    });
  }
}
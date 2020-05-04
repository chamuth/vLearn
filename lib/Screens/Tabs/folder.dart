import 'package:elearnapp/Components/FileItem.dart';
import 'package:elearnapp/Core/API.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FolderData
{
  List<FileData> files = List<FileData>();
}

class FileData
{
  FileItemType type;
  String title; 
  String subtitle; 
  String thumbnail;
  String to;
  String id;
  String filename;
}

class FolderTab extends StatefulWidget {
  FolderTab({Key key}) : super(key: key);

  @override
  FolderTabState createState() => FolderTabState();
}

class FolderTabState extends State<FolderTab> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  String currentFolder = "/";
  String readableFolder = "My Classes/";

  List<String> history = [];

  Map<String, String> classIdNameMap = {  };

  String convertIdsToNames(String org)
  {
    var returner = org;

    classIdNameMap.forEach((key, value) {
      returner = returner.replaceAll(key, value);
    });

    return returner;
  }

  Future<FolderData> getItems() async
  {
    var folder = new FolderData();

    switch(currentFolder)
    {
      case "/": 
        // get all classes
        var classes = await User.getMyClasses(withHost: false);

        for (var i = 0; i < classes.length; i ++)
        {
          classIdNameMap[classes[i]["id"]] = classes[i]["subject"] + " (" + classes[i]["grade"] + ")";

          var file = new FileData();
          file.title = classes[i]["subject"];
          file.subtitle = classes[i]["grade"];
          file.type = FileItemType.classItem;
          file.thumbnail = "";
          file.to = "/" + classes[i]["id"] + "/";
          file.id = classes[i]["id"];

          folder.files.add(file);
        }
        break;

      default:
        var splits = currentFolder.split('/');
        var classId = splits[1];
        var path = splits.getRange(2, splits.length).join("/");

        var files = await API.getFiles(Organization.currentOrganizationId, classId, path);

        for (var i = 0; i < files.length; i ++)
        {
          var file = new FileData();
          file.title = files[i].filename;

          if (files[i].folder)
          {
            file.type = FileItemType.folderItem;
            file.subtitle = "Folder";
            file.to = currentFolder + files[i].filename;
          }
          else 
          {
            file.type = FileItemType.fileItem;
            file.filename = files[i].fullPath;

            if (["image/jpeg", "image/png", "image/gif"].contains(files[i].meta["contentType"]))
              file.type = FileItemType.imageItem;
          }

          print(files[i].fullPath);
          
          file.thumbnail = "";
          // file.id = classes[i]["id"];c

          folder.files.add(file);
        }
    }

    return folder;
  }

  void _onRefresh() async{
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    _refreshController.loadComplete();
  }

  Future<bool> _onWillPop() async
  {
    if (history.length == 0)
      return true;
    else 
    {
      // go back a stage
      setState(() {
        currentFolder = history.removeLast();
      });

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var splits = currentFolder.split('/');
    var readableSplits = readableFolder.split("/");
    
    return new  WillPopScope(
      onWillPop: _onWillPop,
      child: SmartRefresher(
      enablePullDown: true,
      header: WaterDropHeader(),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      controller: _refreshController,
      child: Column(children: <Widget>[
        SizedBox(child: 
          ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Padding(child: 
                BreadCrumb(
                  items: List.generate(splits.length - 1, (i) {
                    return BreadCrumbItem(content: 
                      Text(readableSplits[i], style: TextStyle(fontSize: 16, color: (i == (splits.length - 2)) ? Colors.white : Colors.grey))
                    );
                  }),
                  divider: Icon(Icons.chevron_right, color: Colors.grey[500], size: 14)
                ), padding: EdgeInsets.fromLTRB(15, 10, 0, 0)
              )
            ]
          ), 
        height: 30),

        FutureBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {

          if (snapshot.connectionState == ConnectionState.done)
          {
            return Expanded(child: 
              GridView.count(
                crossAxisCount: (currentFolder == "/") ? 2 : 2,
                padding: EdgeInsets.all(5),
                children: List.generate(snapshot.data.files.length, (index) {
                  return FileItem(title: snapshot.data.files[index].title, filename: snapshot.data.files[index].filename, type: snapshot.data.files[index].type,  subtitle: snapshot.data.files[index].subtitle, onPressed: () { 
                    setState(() {
                      history.add(currentFolder);
                      currentFolder = snapshot.data.files[index].to;
                      readableFolder = convertIdsToNames("My Classes" + snapshot.data.files[index].to);
                    });
                  },);
                }),
              ),
            );
          } else {
            return Expanded(child: Center(child: CircularProgressIndicator()));
          }

        }, future: getItems(),)

      ]),
    ));
  }
}
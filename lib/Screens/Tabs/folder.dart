import 'package:elearnapp/Components/FileItem.dart';
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

  Future<FolderData> getItems() async
  {
    var folder = new FolderData();
    print("get Items called");

    switch(currentFolder)
    {
      case "/": 
        // get all classes
        var classes = await User.getMyClasses(withHost: false);

        for (var i = 0; i < classes.length; i ++)
        {
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
      
        StorageReference shared = FirebaseStorage.instance.ref().child("organizations").child(Organization.currentOrganizationId).child("shared");
        var splits = currentFolder.split('/');

        // go inside the folders
        for (var i = 1; i < splits.length - 1; i++)
        {
          shared = shared.child(splits[i]);
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

  @override
  Widget build(BuildContext context) {
    var splits = currentFolder.split('/');
    var readableSplits = readableFolder.split("/");
    
    return SmartRefresher(
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
                    return BreadCrumbItem(content: Text(readableSplits[i], style: TextStyle(fontSize: 16, color: (i == (splits.length - 2)) ? Colors.white : Colors.grey)));
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
                crossAxisCount: 2,
                padding: EdgeInsets.all(5),
                children: List.generate(snapshot.data.files.length, (index) {
                  return FileItem(title: snapshot.data.files[index].title, subtitle: snapshot.data.files[index].subtitle, onPressed: () { 
                    setState(() {
                      currentFolder = snapshot.data.files[index].to;
                      readableFolder = "My Classes" + (snapshot.data.files[index].to).toString().replaceAll(snapshot.data.files[index].id, snapshot.data.files[index].title + " (" + snapshot.data.files[index].subtitle + ")");
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
    );
  }
}
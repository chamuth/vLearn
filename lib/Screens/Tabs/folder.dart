import 'dart:io';
import 'package:path/path.dart';
import 'package:elearnapp/Components/FileItem.dart';
import 'package:elearnapp/Core/API.dart';
import 'package:elearnapp/Core/Preferences.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:file_picker/file_picker.dart';
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
  int size;
}

class FolderTab extends StatefulWidget {
  FolderTab({Key key, this.startUrl}) : super(key: key);

  String startUrl;

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
        var classes = [];

        if (User.me.teacher)
          classes = await User.getMyClassesAsTeacher();
        else 
          classes = await User.getMyClasses(withHost: false);

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

            file.size = int.tryParse(files[i].meta["size"]);
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
  void initState() {
    Preferences.temporaryColorSwitching = false;

    if (widget.startUrl != null)
    {
      currentFolder = widget.startUrl;
      readableFolder = convertIdsToNames("My Classes" + widget.startUrl);
    }
    
    super.initState();
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
            print(snapshot.data.files);
            if (snapshot.data.files.length == 0)
            {
              if (isUploadingAnything())
                return Expanded(child: Align(alignment: Alignment.center, child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Icon(Icons.cloud_upload, size: 40, color: Colors.grey),
                  Divider(color: Colors.transparent, height: 10),
                  Text("Uploading", style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold)),
                  Divider(color: Colors.transparent, height: 2),
                  Text("Please wait, uploading a file...", style: TextStyle(color: Colors.grey[600], fontSize: 15)),
                ],)));

              if (!isUploadingAnything())
                if (User.me.teacher)
                  return Expanded(child: Align(alignment: Alignment.center, child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Icon(Icons.cloud_upload, size: 40, color: Colors.grey),
                    Divider(color: Colors.transparent, height: 10),
                    Text("No files in this folder", style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold)),
                    Divider(color: Colors.transparent, height: 2),
                    Text("Tap the upload button to upload a file", style: TextStyle(color: Colors.grey[600], fontSize: 15)),
                  ],)));
              if (!isUploadingAnything())
                if (!User.me.teacher)
                  return Expanded(child: Align(alignment: Alignment.center, child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Icon(Icons.folder_open, size: 40, color: Colors.grey),
                    Divider(color: Colors.transparent, height: 10),
                    Text("This folder is empty", style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold)),
                  ],)));

            } else {
              return Expanded(child: 
                GridView.count(
                  crossAxisCount: (currentFolder == "/") ? 2 : 2,
                  padding: EdgeInsets.all(5),
                  children: List.generate(snapshot.data.files.length, (index) {
                    return FileItem(title: snapshot.data.files[index].title, filename: snapshot.data.files[index].filename, type: snapshot.data.files[index].type,  subtitle: snapshot.data.files[index].subtitle, size: snapshot.data.files[index].size,  onPressed: () { 
                      setState(() {
                        history.add(currentFolder);
                        currentFolder = snapshot.data.files[index].to;
                        readableFolder = convertIdsToNames("My Classes" + snapshot.data.files[index].to);

                        print(currentFolder);
                      });
                    },);
                  }),
                ),
              );
            }
          } else {
            return Expanded(child: Center(child: CircularProgressIndicator()));
          }

        }, future: getItems(),),

        if (User.me.teacher)
          Card(child: AnimatedOpacity(child: IgnorePointer(child: Row(children: <Widget>[
            
            Expanded(child: RawMaterialButton(padding: EdgeInsets.fromLTRB(0, 12, 0, 12), child: Column(children: <Widget>[
              Icon(Icons.cloud_upload),
              Divider(color: Colors.transparent, height: 5),
              Text("Upload file(s)", style: TextStyle(fontWeight: FontWeight.bold))
            ],), onPressed: () { 
              startUploadFiles();
            },),),

            Expanded(child: RawMaterialButton(padding: EdgeInsets.fromLTRB(0, 12, 0, 12), child: Column(children: <Widget>[
              Icon(Icons.create_new_folder),
              Divider(color: Colors.transparent, height: 5),
              Text("Create new Folder", style: TextStyle(fontWeight: FontWeight.bold))
            ],), onPressed: () {
              createNewFolder(context);
            },),)

          ],), ignoring: (currentFolder == "/"),), opacity: (currentFolder == "/") ? 0.5 : 1, duration: Duration(milliseconds: 250),),
          color: Colors.grey[800], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),), elevation: 0,)
      ]),
    ));
  }

  bool isUploadingAnything()
  {
    bool uploading = false;

    tasks.forEach((element) {
      if (!(element as StorageUploadTask).isComplete)
        uploading = true;
    });

    return uploading;
  }

  void createNewFolder(context)
  {

  }

  void startUploadFiles() async
  { 

    List<File> files = await FilePicker.getMultiFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'docx', 'png', 'jpeg', 'gif', 'pptx', 'xlsx', 'pdf'],
    );

    if (files != null)
      if (files.length > 0)
      {
        files.forEach((f)
        {
          var task = FirebaseStorage.instance.ref().child("organizations").child(Organization.me.id).child("shared").child(currentFolder.substring(1) + basename(f.path)).putFile(f);

          tasks.add(task);
          setState(() { });

          task.onComplete.then((value) {
            setState(() { });
          });
        });
      }    
  }

  List tasks = [];
}
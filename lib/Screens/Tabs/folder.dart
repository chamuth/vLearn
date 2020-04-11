import 'package:elearnapp/Components/FileItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FolderTab extends StatefulWidget {
  FolderTab({Key key}) : super(key: key);

  @override
  FolderTabState createState() => FolderTabState();
}

class FolderTabState extends State<FolderTab> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: WaterDropHeader(),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      controller: _refreshController,
      child: Column(children: <Widget>[
        SizedBox(child: 
        ListView(
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(child: 
              BreadCrumb(
                items: <BreadCrumbItem>[
                  BreadCrumbItem(content: Text("My Classes", style: TextStyle(color: Colors.grey))),
                ],
                divider: Icon(Icons.chevron_right, color: Colors.grey[500], size: 14)
              ), padding: EdgeInsets.fromLTRB(15, 10, 0, 0)
            )
          ]
        ), height: 30),
        Expanded(child: 
          GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(5),
            children: List.generate(3, (index) {
              return FileItem();
            }),
          ),
        )

      ]),
    );
  }
}
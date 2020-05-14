import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearnapp/Components/ClassViewActionItem.dart';
import 'package:elearnapp/Core/Classes.dart';
import 'package:elearnapp/Core/User.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:elearnapp/Screens/Represents/ClassView.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadedClassView extends StatefulWidget {
  LoadedClassView({Key key, this.data, this.host, this.classDataLoaded, this.actions, this.backdropImageURL}) : super(key: key);

  String backdropImageURL;
  ClassData data;
  User host;
  bool classDataLoaded;
  List<ClassAction> actions;

  @override
  _LoadedClassViewState createState() => _LoadedClassViewState();
}

class _LoadedClassViewState extends State<LoadedClassView> {
  @override
  Widget build(BuildContext context) {
    return  AnimatedCrossFade(duration: Duration(milliseconds: 250), crossFadeState: (widget.classDataLoaded) ? CrossFadeState.showFirst : CrossFadeState.showSecond, firstChild: 
      Padding(
        child: Card(
          child: Stack(children: <Widget>[
            CachedNetworkImage(
              imageUrl: widget.backdropImageURL,
              imageBuilder: (context, imageProvider) => Container(
                height:200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProvider
                  )
                )  
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            
            Container(
              height:200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Theme.of(context).cardColor.withOpacity(0.65),
                    Theme.of(context).cardColor.withOpacity(1.0),
                  ],
                  stops: [0.0, 1.0]
                )
              ),
            ),

            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Row(children: <Widget>[
                    Text(widget.data.grade, style: TextStyle(fontSize: 16, color: Colors.grey[350], fontWeight: FontWeight.bold)),
                    VerticalDivider(width: 8),
                    Text("·", style: TextStyle(color: Colors.grey[400], fontSize: 20)),
                    VerticalDivider(width: 8),
                    Text(Organization.me.name, style: TextStyle(fontSize: 16, color: Colors.grey[350], fontWeight: FontWeight.bold)),
                  ],),
                  Divider(color: Colors.transparent, height: 3),
                  Text(widget.data.subject, style: TextStyle(fontSize: 30)),
                  Divider(color: Colors.transparent, height: 7),

                  Row(children: <Widget>[
                    Text("By ", style: TextStyle(fontSize: 17, color: Colors.grey[400], fontWeight: FontWeight.bold)),
                    Text(User.getSanitizedName(widget.host), style: TextStyle(fontSize: 17, color: Colors.grey[100], fontWeight: FontWeight.bold))
                  ])
                ])
              ),

              Padding(
                child: GridView.count(shrinkWrap: true, crossAxisCount: 3, children: List.generate(widget.actions.length, (index) {
                  return ActionItem(actions: widget.actions, index: index);
                })),
                padding: EdgeInsets.fromLTRB(5, 5, 5, 7)
              ),

            ]),

          ],) 
          , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), clipBehavior: Clip.antiAlias,
        ), 
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5)
      ), 
      secondChild: Padding(child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 250.0,
        child: Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor,
          highlightColor: Colors.grey[500],
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), clipBehavior: Clip.antiAlias,
          )
        ),
      ), padding: EdgeInsets.fromLTRB(10, 5, 10, 5))
    );
  }
}
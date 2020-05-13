import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearnapp/Core/API.dart';
import 'package:elearnapp/Core/Ellipsis.dart';
import 'package:elearnapp/Core/Events.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class EventCard extends StatefulWidget {
  EventCard({Key key, this.type, this.event}) : super(key: key);

  EventType type;
  Event event;

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> 
{
  List files = [];

  void loadEventPhotos() async
  {
    var f = await API.loadEventPhotos(widget.event.id);
    f.forEach((element) {
      
      FirebaseStorage.instance.ref().child(element.fullPath).getDownloadURL().then((url) {
        print(url);

        setState(() {
          files.add({
            "url" : url,
            "data": element
          });
        });
      });
      
    });
  }

  double calcProgressBar(progress)
  {
    try
    {
      var d = progress.downloaded / progress.totalSize;
      return d;
    }
    catch(ex)
    {
      return 0;
    }
  }

  int crossAxisCount()
  {
    if (files.length > 3)
      return 3;
    else if (files.length > 0)
      return files.length;
    else 
      return 3;
  }
  
  int crossAxisLength()
  {
    if (files.length > 6)
      return 6;
    if (files.length > 3)
      return 3;
    else
      return files.length;
  }

  @override
  void initState() {
    loadEventPhotos();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Card(
        child: Column(children: <Widget>[
          Padding(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              
              Row(children: <Widget>[
                Expanded(child: Text(widget.event.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                Text(timeago.format(widget.event.created), style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 12))
              ],),

              Divider(color: Colors.transparent, height: 2),
              Text(ellipsis(widget.event.description, 200), textAlign: TextAlign.start, style: TextStyle(color: Colors.grey[400])),
              Divider(color: Colors.transparent, height: 3),

            ],), padding: EdgeInsets.fromLTRB(10, 7, 10, 7),
          ),

          if(widget.event.type == EventType.album)
            AnimatedCrossFade(crossFadeState: (files.length > 0) ? CrossFadeState.showFirst: CrossFadeState.showSecond, firstChild: 
              GridView.count(physics: NeverScrollableScrollPhysics(), crossAxisCount: crossAxisCount(), shrinkWrap: true, crossAxisSpacing: 0, mainAxisSpacing: 0, children: 
              List.generate((files.length > crossAxisLength()) ? crossAxisLength() : files.length, (index)
              {
                if (files.length > crossAxisLength() && index == crossAxisLength() - 1)
                {
                  return Stack(fit: StackFit.expand, children: <Widget>[
                    CachedNetworkImage(imageUrl: files[index]["url"], imageBuilder: (context, imageProvider) {
                      return Image(fit: BoxFit.cover, image: imageProvider);
                    }, progressIndicatorBuilder: (context, url, progress) {
                      return Padding(child: CircularProgressIndicator(value: calcProgressBar(progress)), padding: EdgeInsets.all(25));
                    },),
                    Container(color: Colors.grey[900].withOpacity(0.65)),
                    Align(child: Text("+" + (files.length - crossAxisLength()).toString(), style: TextStyle(fontSize: 30), textAlign: TextAlign.center,), alignment: Alignment.center,)
                  ],);
                } else {
                  return CachedNetworkImage(imageUrl: files[index]["url"], imageBuilder: (context, imageProvider) {
                    return Image(fit: BoxFit.cover, image: imageProvider);
                  }, progressIndicatorBuilder: (context, url, progress) {
                    return Padding(child: CircularProgressIndicator(value: calcProgressBar(progress)), padding: EdgeInsets.all(25));
                  },);
                }
              }),), duration: Duration(milliseconds: 250), secondChild: GridView.count(physics: NeverScrollableScrollPhysics(), crossAxisCount: 3, shrinkWrap: true, crossAxisSpacing: 0, mainAxisSpacing: 0, children: List.generate(6, (i) {
                return Shimmer.fromColors(child: Card(margin: EdgeInsets.all(2)), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]);
            })))

        ],),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
      ), 
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
    );
  }
}
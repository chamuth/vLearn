import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NoticeboardShimmer extends StatelessWidget {
  const NoticeboardShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        VerticalDivider(width: 0),
        Shimmer.fromColors(child: CircleAvatar(radius: 15, backgroundColor: Theme.of(context).primaryColor,), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]),
        VerticalDivider(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.3, height: 20),
          SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 1, height: 35),
          Row(children: <Widget>[
            SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.3, height: 18),
            SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.4, height: 18),
          ],),
          SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.2, height: 18),
        ],)),
      ],), 
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
    ));
  }
}
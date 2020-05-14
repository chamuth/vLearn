import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ClassViewActivityShimmer extends StatelessWidget {
  const ClassViewActivityShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      child: Row(children: <Widget>[
        Shimmer.fromColors(child: CircleAvatar(radius: 18, backgroundColor: Theme.of(context).primaryColor,), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]),
        VerticalDivider(),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.3, height: 20),
          SizedBox(child: Shimmer.fromColors(child: Card(), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]), width: MediaQuery.of(context).size.width * 0.5, height: 20)
        ],)),
        Shimmer.fromColors(child: CircleAvatar(radius: 12, backgroundColor: Theme.of(context).primaryColor,), baseColor: Colors.grey[700], highlightColor: Colors.grey[500]),
        VerticalDivider(width:10),
      ],), 
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
    ));
  }
}
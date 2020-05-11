import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:flutter/material.dart';

class LoadedOrganizationCard extends StatefulWidget {
  LoadedOrganizationCard({Key key}) : super(key: key);

  @override
  _LoadedOrganizationCardState createState() => _LoadedOrganizationCardState();
}

class _LoadedOrganizationCardState extends State<LoadedOrganizationCard> {
  @override
  Widget build(BuildContext context) {
    return Card(child: Stack(children: <Widget>[

          if (Organization.organizationCoverUrl != null && Organization.organizationCoverUrl != "")
            CachedNetworkImage(imageBuilder : (context, provider) {
              return Container(
                height: 175,
                decoration: BoxDecoration(image: DecorationImage(image: provider, fit: BoxFit.cover)),
              );
            }, imageUrl: Organization.organizationCoverUrl,),

          Container(
            height: 175,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.grey[850].withOpacity(0.2),
                  Colors.grey[850]
                ],
                stops: [0.0, 1.0]
              )
            ),
          ),

          Padding(child: Row(children: <Widget>[
            
            if (Organization.organizationLogoUrl != null && Organization.organizationLogoUrl != "")
              CachedNetworkImage(imageBuilder : (context, provider) {
                return Container(
                  height:50,
                  width:50,
                  decoration: BoxDecoration(image: DecorationImage(image: provider, fit: BoxFit.fitHeight)),
                );
              }, imageUrl: Organization.organizationLogoUrl,),

            VerticalDivider(width: 10),

            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text(Organization.me.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Divider(height: 2, color: Colors.transparent),
              Text(Organization.me.subtitle, style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],))
            
          ],), padding: EdgeInsets.fromLTRB(15, 110, 15, 0)),
            

        ],));
  }
}
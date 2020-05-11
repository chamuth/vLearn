import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearnapp/Components/EventCard.dart';
import 'package:elearnapp/Components/LoadedOrganizationCard.dart';
import 'package:elearnapp/Components/Seperator.dart';
import 'package:elearnapp/Core/Events.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class OrganizationTab extends StatefulWidget {
  OrganizationTab({Key key}) : super(key: key);

  @override
  _OrganizationTabState createState() => _OrganizationTabState();
}

class _OrganizationTabState extends State<OrganizationTab> {
  List<Event> events = [];

  @override
  void initState() {
    Event.loadAllEvents().then((e) {
      setState(() {
        events = e;
      });
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        
        LoadedOrganizationCard(),

        Divider(color: Colors.transparent, height: 10),
        
        Column(children: List.generate(events.length, (index) {
          return TouchableOpacity(child: EventCard(event: events[index]), onTap: () { }, activeOpacity: 0.85,);
        }))

      ],
    );
  }
}
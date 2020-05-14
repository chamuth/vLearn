
import 'package:cloud_firestore/cloud_firestore.dart';

import 'User.dart';

enum EventType
{
  album, celebration
}

class Event
{
  String id;
  String name;
  String description;
  DateTime created;
  EventType type;

  Event({this.name, this.description, this.created, this.type});

  Event.fromSnapshot(snap)
  {
    var data = snap["data"];

    id = snap["id"];
    name = data["name"];
    description = data["description"];
    created = (data["created"] as Timestamp).toDate(); 

    switch (data["type"])
    {
      case "album" :
        type = EventType.album;
        break;
      case "celebration" :
        type = EventType.celebration;
        break;
      default :
        type = EventType.celebration;
        break;
    }
  }

  static Future<List<Event>> loadAllEvents() async
  {
    var snapshot = await User.getMyOrg().collection("events").orderBy("created", descending: true).getDocuments();

    List<Event> events = [];

    snapshot.documents.forEach((e) {
      events.add(Event.fromSnapshot({
        "id" : e.documentID,
        "data" : e.data
      }));
    });

    return events;
  }
}
import 'dart:math';

import 'package:elearnapp/Components/ConversationItem.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class ChatTab extends StatefulWidget {
  ChatTab({Key key}) : super(key: key);

  @override
  ChatTabState createState() => ChatTabState();
}

class ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    var faker = new Faker();
    var rng = new Random();

    return ListView.builder(itemCount: 15, itemBuilder: (context, index) {
      return RawMaterialButton(child: ConversationItem(conversationTitle: faker.person.prefix() + " " + faker.person.name(), lastMessage: faker.lorem.sentence(), unreadMessages: rng.nextInt(4),), onPressed: () { });
    });
  }
}
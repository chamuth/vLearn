import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearnapp/Data/Organization.dart';

import 'Classes.dart';
import 'User.dart';

class Invite
{
  static Future processInvite(String invite)
  {
    Uri uri = Uri.parse(invite);
    Firestore.instance.collection("organizations").document(Organization.currentOrganizationId).collection("classes").document(uri.queryParameters["c"]).get().then((value){
      if (uri.queryParameters["i"] == value.data["invite"])
      {
        User.getUser(value.data["host"]).then((user) {
          return {
            "classData" : ClassData.fromData(value),
            "host" : user
          };
        });
      } else {
        return null;
      }
    });
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearnapp/Data/Organization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'User.dart';

class PushNotificationsManager {

  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
        onMessage: (message) async
        {
          print("Message: $message");
        },
        onResume: (message) async
        {
          print("Message: $message");
        },
        onLaunch: (message) async
        {
          print("Message: $message");
        },
      );

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      // Save the user token on the servers
      Firestore.instance.collection("users").document(User.me.uid).updateData({
        'messageToken' : token
      });

      print(token);
      
      _initialized = true;
    }
  }
}
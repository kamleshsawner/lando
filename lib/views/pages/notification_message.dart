import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lando/model/firebase_message.dart';


class FirebaseNotificationView extends StatefulWidget {
  @override
  _FirebaseNotificationViewState createState() => _FirebaseNotificationViewState();
}

class _FirebaseNotificationViewState extends State<FirebaseNotificationView> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<MyFireBaseMessage> messages = [];

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String,dynamic> message) async {
        print('onMessage : $message');
        final notification = message['notification'];
        setState(() {
          messages.add(MyFireBaseMessage(
              title: notification['title'], body: notification['body']));
        });
      },
      onLaunch: (Map<String,dynamic> message) async {
        print('onLaunch : $message');
        final notification = message['data'];
        setState(() {
          messages.add(MyFireBaseMessage(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
      });
        },
      onResume: (Map<String,dynamic> message) async {
        print('onResume : $message');
      }
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  Widget build(BuildContext context) => ListView(
    children: messages.map(buildMessage).toList(),
  );

  Widget buildMessage(MyFireBaseMessage message) => ListTile(
    title: Text(message.title),
    subtitle: Text(message.body),
  );
}

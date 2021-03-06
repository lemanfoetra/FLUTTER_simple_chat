import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_chat/widgets/chat/message.dart';
import 'package:simple_chat/widgets/chat/new_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    final frm = FirebaseMessaging();
    frm.requestNotificationPermissions();
    frm.configure(onMessage: (message) {
      print(message);
      print("on Message");
      return;
    }, onLaunch: (value) {
      print(value);
      print("on launch");
      return;
    }, onResume: (value) {
      print(value);
      print("on resume");
      return;
    });
    frm.subscribeToTopic('chat');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 5),
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              underline: Container(), // hide underline
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Message(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}

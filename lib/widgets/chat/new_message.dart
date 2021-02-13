import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _messageController = TextEditingController();
  String message = '';

  void _sendMessageFn() async {
    // Menghilangkan keyboard saat send ditekan
    FocusScope.of(context).unfocus();
    final userId = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('chat').add({
      'text': message,
      'created_at': Timestamp.now(),
      'user_id': userId.uid,
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: "Send message.."),
              onChanged: (value) {
                setState(() {
                  message = value.trim();
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: message.isEmpty ? null : _sendMessageFn,
          )
        ],
      ),
    );
  }
}

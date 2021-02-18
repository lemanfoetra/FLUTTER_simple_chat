import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_chat/widgets/chat/bubble_message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (futureSnapshot.hasError) {
          return Center(
            child: Text(futureSnapshot.error.toString()),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('created_at', descending: true)
              .snapshots(),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (chatSnapshot.hasError) {
              return Container();
            } else {
              final data = chatSnapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemCount: data.length,
                itemBuilder: (ctx, i) {
                  if (data[i]['text'] == null) {
                    return Container();
                  }
                  return BubbleMessage(
                    username: data[i]['username'],
                    message: data[i]['text'],
                    isMe: data[i]['user_id'] == futureSnapshot.data.uid,
                    key: ValueKey(data[i].documentID),
                    imageUrl: data[i]['image_url'] ?? null,
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}

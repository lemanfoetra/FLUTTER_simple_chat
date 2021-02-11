import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              return Text(data[i]['text']);
            },
          );
        }
      },
    );
  }
}

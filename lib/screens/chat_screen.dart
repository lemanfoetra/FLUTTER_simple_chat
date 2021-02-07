import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/pCOBPMJt44ZD4Yh1Qhoz/messages')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            final data = snapshot.data.documents;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (ctx, i) => Container(
                padding: EdgeInsets.all(10),
                child: Text(data[i]['text']),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/pCOBPMJt44ZD4Yh1Qhoz/messages')
              .add({'text': 'How are you?'});
        },
      ),
    );
  }
}

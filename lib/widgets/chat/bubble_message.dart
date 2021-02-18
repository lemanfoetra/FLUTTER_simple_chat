import 'package:flutter/material.dart';

class BubbleMessage extends StatelessWidget {
  final String message;
  final String imageUrl;
  final bool isMe;
  final key;
  final String username;

  BubbleMessage({
    this.message,
    this.isMe,
    this.key,
    this.imageUrl,
    this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Stack(
            overflow: Overflow.visible,
            fit: StackFit.loose,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                  maxWidth: 300,
                ),
                decoration: BoxDecoration(
                  color:
                      isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(12),
                    bottomLeft:
                        !isMe ? Radius.circular(0) : Radius.circular(12),
                  ),
                ),
                padding: EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe ? Colors.black54 : Colors.white70,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        color: isMe ? Colors.black87 : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -15,
                right: !isMe ? 2 : null,
                left: isMe ? 5 : null,
                child: CircleAvatar(
                  backgroundImage:
                      imageUrl != null ? NetworkImage(imageUrl) : null,
                  backgroundColor: Colors.lightBlue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

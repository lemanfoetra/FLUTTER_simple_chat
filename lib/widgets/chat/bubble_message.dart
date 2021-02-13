import 'package:flutter/material.dart';

class BubbleMessage extends StatelessWidget {
  final String message;
  BubbleMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Text(message),
    );
  }
}

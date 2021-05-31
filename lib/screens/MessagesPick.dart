import 'package:chat/widgets/favorite_contacts.dart';
import 'package:chat/widgets/recent_chats.dart';
import 'package:flutter/material.dart';

class MessagesPick extends StatefulWidget {


  @override
  _MessagesPickState createState() => _MessagesPickState();
}

class _MessagesPickState extends State<MessagesPick> {


  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: [
                  FavoriteContacts(),
                  RecentChats(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

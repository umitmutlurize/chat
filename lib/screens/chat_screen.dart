import 'dart:math';
import 'package:chat/HelperSharedPref/shared_preferences.dart';
import 'package:chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatUserName, name;

  ChatScreen(this.chatUserName, this.name);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var chatRoomId, messageId = "";
  var myName, myProfilePic, myUserName, myEmail;
  var messageStream;
  TextEditingController messageController = TextEditingController();

  _builMessage(String message, bool sendByMe, Timestamp time) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomRight:
                    sendByMe ? Radius.circular(0) : Radius.circular(24),
                topRight: Radius.circular(24),
                bottomLeft: sendByMe ? Radius.circular(24) : Radius.circular(0),
              ),
              color: sendByMe ? Colors.blue : Color(0xFFEA003E),
            ),
            padding: EdgeInsets.all(16),
            child: Text(
              message,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
              child: TextField(
            style: TextStyle(color: Colors.black),
            textCapitalization: TextCapitalization.sentences,
            controller: messageController,
            decoration: InputDecoration.collapsed(hintText: 'Mesaj Gönder...'),
          )),
          IconButton(
            onPressed: () {
              addMessage(true);
              FocusScope.of(context).unfocus();
            },
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  myInfoFromSharedPrefence() async {
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    chatRoomId = getChatRoomIdByUserNames(widget.chatUserName, myUserName);
  }

  getChatRoomIdByUserNames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  getAndSetMessages() async {
    messageStream = await DataBaseMethods().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  doThisOnLunch() async {
    await myInfoFromSharedPrefence();
    await getAndSetMessages();
  }

  String randomNumberManuel(int len) {
    var r = Random();
    const _chars =
        "QqWwEeRrTtYyUuIıOoPpĞğÜüAaSsDdFfGgHhJjKkLlŞşİiÇçÖöMmNnbBVvCcXxZz1234567890";
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  addMessage(bool sendClicked) {
    if (messageController.text != "") {
      String message = messageController.text;

      var lastMessagetime = DateTime.now();
      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUserName,
        "time": lastMessagetime,
        "imgUrl": myProfilePic
      };
      if (messageId == "") {
        messageId = randomNumberManuel(12);
      }

      DataBaseMethods()
          .addMessage(chatRoomId, messageId, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageTime": lastMessagetime,
          "lastMessageSendBy": myUserName
        };
        DataBaseMethods().updateLastMessageSend(chatRoomId, lastMessageInfoMap);

        if (sendClicked) {
          messageController.text = "";
        }

        messageId = "";
      });
    }
  }

  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: messageStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Mesajlar Yüklenemedi Aslan Parçası');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.black,
          ));
        }
        if (messageStream != null) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return _builMessage(
                  ds["message"], myUserName == ds["sendBy"], ds["time"]);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void initState() {
    doThisOnLunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: chatMessages(),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}

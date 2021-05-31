import 'package:chat/HelperSharedPref/shared_preferences.dart';
import 'package:chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearch = false;
  DataBaseMethods db = new DataBaseMethods();
  TextEditingController searchTextEdit = TextEditingController();
  var userStream;

  var myName, myProfilePic, myEmail;
  late String myUserName;

  myInfoFromSharedPrefence() async {
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUserName = (await SharedPreferenceHelper().getUserName())!;
    myEmail = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  getChatRoomIdByUserNames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  onSearchBtnClick() async {
    isSearch = true;
    setState(() {});
    userStream = await DataBaseMethods().getUserByUserName(searchTextEdit.text);
    setState(() {});
  }




  Widget searchUserInfo(
      {required String profileUrl,
      required String name,
      required String username,
      required String email}) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByUserNames(myUserName, username);

        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserName, username],
        };
        DataBaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(username, name)));
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40.0),
            child: Image.network(
              profileUrl,
              height: 30.0,
              width: 30.0,
            ),
          ),
          SizedBox(
            width: 12.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(name), Text(email)],
          )
        ],
      ),
    );
  }

  Widget searchUsersList() {
    return StreamBuilder<QuerySnapshot>(
      stream: userStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Birşey Ters gitti aslan parçası');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Yükleniyor...");
        }
        if (userStream != null) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return searchUserInfo(
                username: ds["username"],
                profileUrl: ds["imgUrl"],
                name: ds["name"],
                email: ds["email"],
              );
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
    myInfoFromSharedPrefence();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Kişi Ara'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                isSearch
                    ? GestureDetector(
                        onTap: () {
                          searchTextEdit.text = '';
                          isSearch = false;
                          setState(() {});
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white54,
                          ),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    margin: EdgeInsets.symmetric(vertical: 6.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          autofocus: false,
                          controller: searchTextEdit,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.blueGrey,
                          cursorHeight: 20.0,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Kullanıcı Adı',
                              hintStyle: TextStyle(color: Colors.white54)),
                        )),
                        IconButton(
                          icon: Icon(Icons.search),
                          color: Colors.white54,
                          hoverColor: Colors.black,
                          focusColor: Colors.black,
                          splashColor: Colors.black,
                          highlightColor: Colors.black,
                          disabledColor: Colors.black,
                          onPressed: () {
                            if (searchTextEdit.text != "") {
                              onSearchBtnClick();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            searchUsersList()
          ],
        ),
      ),
    );
  }
}

import 'package:chat/Helper/otomatikgir.dart';
import 'package:chat/HelperSharedPref/shared_preferences.dart';
import 'package:chat/screens/searchScreen.dart';

import 'package:chat/services/auth_dart.dart';
import 'package:chat/services/database.dart';

import 'package:chat/widgets/category_selector.dart';
import 'package:chat/widgets/favorite_contacts.dart';
import 'package:chat/widgets/recent_chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  TextEditingController searchTextEdit = TextEditingController();
  bool searchTick = false;
  DataBaseMethods dataBaseMethods = DataBaseMethods();


  var myName, myProfilePic, myUserName, myEmail;

  myInfoFromSharedPrefence() async {
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  Widget searchList() {
    return ListView.builder(
        itemCount: searchSnapShot.docs.length,
        itemBuilder: (context, index) {
          return SearchTile(email: "", username: '');
        });
  }

  late QuerySnapshot searchSnapShot;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 30,
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text(
          'Mesajlar',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              icon: Icon(Icons.search),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              icon: Icon(Icons.exit_to_app),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
                authenticationMethods.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AutomaticGiris()));
              },
            ),
          ),
        ],
      ),
      body: searchTick
          ? GestureDetector(
              onTap: () {
                setState(() {
                  searchTextEdit.text = "";
                });
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color(0x36FFFFFF),
                            Color(0x8FFFFFF)
                          ])),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                CategorySelector(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1,
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
            ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String username;
  final String email;

  SearchTile({required this.username, required this.email});

  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                username,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                email,
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text('Mesaj Gönder'),
              )
            ],
          )
        ],
      ),
    );
  }
}

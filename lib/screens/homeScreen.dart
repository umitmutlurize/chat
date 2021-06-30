import 'package:chat/Helper/otomatikgir.dart';
import 'package:chat/HelperSharedPref/shared_preferences.dart';
import 'package:chat/screens/MessagesPick.dart';
import 'package:chat/screens/searchScreen.dart';

import 'package:chat/services/auth_dart.dart';
import 'package:chat/services/database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  TextEditingController searchTextEdit = TextEditingController();
  bool searchTick = false;
  DataBaseMethods dataBaseMethods = DataBaseMethods();

  var myName, myProfilePic, myUserName, myEmail;

  // BURASI BOTTOM BAR IN YAPILDIĞI BODY KISMININ DEĞİŞTİĞİ BÖLÜMDÜR

  myInfoFromSharedPrefence() async {
    myName = await SharedPreferenceHelper().getDisplayName()??"";
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl()??"";
    myUserName = await SharedPreferenceHelper().getUserName()??"";
    myEmail = await SharedPreferenceHelper().getUserEmail()??"";
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
  void initState() {
    myInfoFromSharedPrefence();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(child: Text('Başlık')),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Mesajlar'),
                ),
                ListTile(
                  leading: Icon(Icons.palette_rounded),
                  title: Text('Resimsss'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Ayarsss'),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(shape: BoxShape.circle,
                      image:
                          DecorationImage(image: NetworkImage(myProfilePic))),
                )
              ],
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AutomaticGiris()));
                  },
                ),
              ),
            ],
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 5.0,
              tabs: [
                Tab(
                  icon: Icon(Icons.message_sharp),
                  text: 'MESAJ',
                ),
                Tab(
                  icon: Icon(Icons.message_sharp),
                  text: 'Çağrı',
                ),
                Tab(
                  icon: Icon(Icons.message_sharp),
                  text: 'Arama',
                ),
                Tab(
                  icon: Icon(Icons.message_sharp),
                  text: 'Keşfet',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              MessagesPick(),
              buildPage("ikinci Adım"),
              buildPage("üç Adım"),
              buildPage("Dört Adım"),
            ],
          )),
    );
  }

  Widget buildPage(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 28.0),
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

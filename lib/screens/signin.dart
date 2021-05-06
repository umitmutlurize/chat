import 'package:chat/services/GoogleSignUpButton.dart';
import 'package:chat/services/google.dart';
import 'package:chat/utils/authGoogle.dart';

import 'package:chat/widgets/SignInputDecoration.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toogle;

  SignIn(this.toogle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Yap'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          alignment: Alignment.center,
          child: Container(
            color: Colors.black.withOpacity(0.95),
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: textInputDeco('E-mail'),
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: textInputDeco('Şifre'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Şifrenizi mi Unuttunuz?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () {},
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF007EF4),
                          Color(0xFF2A75BC),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      'Giriş Yap',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
             GoogleSignInButton(),

                SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hesabın yoksa =>   ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toogle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Buraya Tıkla ve Gör',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                  ],
                ),

              ],

            ),
          ),
        ),
      ),
    );
  }
}

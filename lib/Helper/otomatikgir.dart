import 'package:chat/screens/Signup.dart';
import 'package:chat/screens/signin.dart';
import 'package:flutter/material.dart';

class AutomaticGiris extends StatefulWidget {
  @override
  _AutomaticGirisState createState() => _AutomaticGirisState();
}

class _AutomaticGirisState extends State<AutomaticGiris> {

  bool showSignIn= true;
void toggleView(){
  setState(() {
 showSignIn=!showSignIn;
  });
}

  @override
  Widget build(BuildContext context) {
     if(showSignIn){
       return SignIn(toggleView);

    }else{
       return SignUp(toggleView);
     }
  }
}

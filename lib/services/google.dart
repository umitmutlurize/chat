import 'package:chat/HelperSharedPref/shared_preferences.dart';
import 'package:chat/screens/homeScreen.dart';
import 'package:chat/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMetodlars {
  final FirebaseAuth auth = FirebaseAuth.instance;

 Future getCurrentUser() async{
    return await auth.currentUser;
  }

   Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;

      if(user!=null){
        SharedPreferenceHelper().saveUserEmail(user.email.toString());
        SharedPreferenceHelper().saveUserId(user.uid);
        SharedPreferenceHelper().saveUserName(user.email!.replaceAll("@gmail.com", ""));
        SharedPreferenceHelper().saveDisplayName(user.displayName.toString());
        SharedPreferenceHelper().saveUserProfileUrl(user.photoURL.toString());


      }

      Map<String, dynamic> userInfoMap = {
        "email": user!.email,
        "username": user.email!.replaceAll("@gmail.com", ""),
        "name": user.displayName,
        "imgUrl": user.photoURL,
      };

      DataBaseMethods().addUserInfoToDB(user.uid, userInfoMap).then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        AuthMetodlars.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }
}

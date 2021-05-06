import 'package:chat/screens/signin.dart';
import 'package:chat/services/auth_dart.dart';

import 'package:chat/widgets/SignInputDecoration.dart';

import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toogle;

  SignUp(this.toogle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController mailTextEditingController = TextEditingController();
  TextEditingController pwTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController surNameTextEditingController = TextEditingController();
  AuthenticationMethods authmethods = AuthenticationMethods();


  signMeUp() {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;

      });
      authmethods
          .signUpWithEmailAndPassword(
              mailTextEditingController.text, pwTextEditingController.text)
          .then((val) {
        print('${val.uid}');



        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SignIn(widget.toogle)));
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt OL!'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: Container(
                  color: Colors.black.withOpacity(0.95),
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) {
                                return val!.isEmpty || val.length < 3
                                    ? "3 karakterden büyük bir kullanıcın olmalı"
                                    : null;
                              },
                              controller: userNameTextEditingController,
                              style: TextStyle(color: Colors.white),
                              decoration: textInputDeco('Kullanıcı Adı'),
                            ),
                            TextFormField(
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val!)
                                    ? null
                                    : "Doğru düzgün email girer misin";
                              },
                              controller: mailTextEditingController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.white),
                              decoration: textInputDeco('E-mail'),
                            ),
                            TextFormField(
                              validator: (val) {
                                return val!.length < 6
                                    ? "6 dan büyük bir şifre girmezsen açmam "
                                    : null;
                              },
                              controller: pwTextEditingController,
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                              decoration: textInputDeco('Şifre'),
                            ),
                            TextFormField(
                              validator: (val) {
                                return val!.length < 1
                                    ? "Bir isim giriver bi zahmet "
                                    : null;
                              },
                              controller: nameTextEditingController,
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                              decoration: textInputDeco('Ad'),
                            ),
                            TextFormField(
                              validator: (val) {
                                return val!.length < 1
                                    ? "Bir soyisim giriver bi zahmet "
                                    : null;
                              },
                              controller: surNameTextEditingController,
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                              decoration: textInputDeco('Soyad'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          'Şifrenizi mi Unuttunuz?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextButton(
                        onPressed: () {
                          signMeUp();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
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
                            'Kayıt OL',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            'Google İle Kayıt Ol',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 17),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hesabın varsa =>   ',
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toogle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Buraya Tıkla ne işin var burda',
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

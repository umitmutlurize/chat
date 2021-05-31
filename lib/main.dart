import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Helper/otomatikgir.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cHAT',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity,
scaffoldBackgroundColor: Colors.black.withOpacity(0.95),
        primarySwatch: Colors.red,
       primaryColor: Color(0xFF145C9E),
        accentColor: Color(0xFFFEF985),
      ),
      home: AutomaticGiris(),

    );
  }

}



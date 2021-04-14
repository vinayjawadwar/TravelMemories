import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './Login.dart';
import './SignUp.dart';
import './Start.dart';
import './HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.lightBlue),
      debugShowCheckedModeBanner: false,
      home: HomePage(),

      // we are using this routes insted of materialpageroute because when user signed out of app after getting back he again will able to see signed in
      //this will fix this issue

      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "Start": (BuildContext context) => Start()
      },
    );
  }
}

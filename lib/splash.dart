import 'dart:async';

import 'package:fanpage/login.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySplashPage(title: 'FanPage Application'),
    );
  }
}

class MySplashPage extends StatefulWidget {
  MySplashPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MySplashPageState createState() => _MySplashPageState();
}

class _MySplashPageState extends State<MySplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginHomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Image(image: AssetImage('assets/Gaurav_J.jpg')));
  }
}

import 'dart:async';
import 'package:fanpage/pages/errorpage.dart';
import 'package:fanpage/pages/loading.dart';
import 'package:fanpage/login.dart';
import 'package:fanpage/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialize = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
            body: FutureBuilder(
                future: _initialize,
                builder: (context, snapshot) {
                  if (snapshot.hasError) return ErrorPage();
                  if (snapshot.connectionState == ConnectionState.done)
                    return MyApp();
                  else
                    return LoadingPage();
                })));
  }
}

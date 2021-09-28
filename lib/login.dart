import 'package:fanpage/pages/errorpage.dart';
import 'package:fanpage/screens/admin.dart';
import 'package:fanpage/screens/homescreen.dart';
import 'package:fanpage/screens/mainscreen.dart';
import 'package:fanpage/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: "APP",
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    if (user != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (user.uid == 'w3tGv1wzp7hm70G6TRq2w3rS00n2') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AdminScreen()));
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      });
    }
    return MainScreen();
  }
}

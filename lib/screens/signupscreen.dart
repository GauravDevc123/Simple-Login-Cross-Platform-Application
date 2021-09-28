import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/screens/mainscreen.dart';
import 'package:fanpage/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SIGN UP"),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "EMAIL...",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "PASSWORD...",
                ),
                obscureText: true,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  hintText: "FIRST NAME...",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  hintText: "LAST NAME...",
                ),
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              color: Colors.blue,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
                child: Text("LOG IN"),
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              color: Colors.red,
              child: FlatButton(
                onPressed: () {
                  final String email = emailController.text.trim();
                  final String password = passwordController.text.trim();
                  final String firstName = firstNameController.text.trim();
                  final String lastName = lastNameController.text.trim();

                  if (email.isEmpty) {
                    print("Email is Empty");
                  } else {
                    if (password.isEmpty) {
                      print("Password is Empty");
                    } else {
                      context
                          .read<AuthService>()
                          .signUp(
                            email,
                            password,
                            firstName,
                            lastName,
                          )
                          .then((value) async {
                        User user = FirebaseAuth.instance.currentUser!;

                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(user.uid)
                            .set({
                          'uid': user.uid,
                          'firstName': firstName,
                          'lastName': lastName,
                          'user role': 'customer',
                          'registration DateTime': DateTime.now(),
                        });
                      });
                    }
                  }
                },
                child: Text("SIGN UP"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

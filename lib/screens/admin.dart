import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/screens/mainscreen.dart';
import 'package:fanpage/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController _textFieldController = new TextEditingController();
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('messages');

  var rng = new Random();
  @override
  Widget build(BuildContext context) {
    showAlertBox() {
      Alert(
        context: context,
        content: TextField(
          onChanged: (value) {},
          controller: _textFieldController,
          decoration: InputDecoration(hintText: "Enter Message"),
        ),
        buttons: [
          DialogButton(
            child: Text("Add"),
            onPressed: () async {
              await collectionReference.add({
                'mid': rng.nextInt(100),
                'message': _textFieldController.text,
                'message dateTime': DateTime.now(),
              });
            },
          ),
        ],
      ).show();
    }

    showPopUpBox() {
      Alert(
        context: context,
        content: Text("Are you sure you want to Log Out?"),
        buttons: [
          DialogButton(
            child: Text("Log Out"),
            onPressed: () {
              context.read<AuthService>().signOutMethod();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MainScreen()));
            },
          ),
        ],
      ).show();
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              padding: EdgeInsets.all(16),
              color: Colors.red,
              child: Text(
                'Add Message',
                style: Theme.of(context).textTheme.headline6,
              ),
              onPressed: showAlertBox,
            ),
            Expanded(
                child: StreamBuilder(
              stream: collectionReference.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data!.docs
                        .map((e) => ListTile(
                              title: Text(e['message']),
                            ))
                        .toList(),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
            RaisedButton(
              padding: EdgeInsets.all(16),
              color: Colors.red,
              child: Text(
                'Log Out',
                style: Theme.of(context).textTheme.headline6,
              ),
              onPressed: showPopUpBox,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("Logged In successfully");
      return "Logged In";
    } catch (e) {
      print("Error Logging in");
      return "Error Logging in";
    }
  }

  Future<String> signUp(
      String email, String password, String firstName, String lastName) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User user = FirebaseAuth.instance.currentUser!;

        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          'uid': user.uid,
          'firstName': firstName,
          'lastName': lastName,
          'user role': 'customer',
          'registration DateTime': DateTime.now(),
        });
      });
      return "Signed Up";
    } catch (e) {
      return "Error Signing in";
    }
  }

  Future<void> signOutMethod() async {
    await _auth.signOut();
  }
}

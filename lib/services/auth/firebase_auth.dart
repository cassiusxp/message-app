import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<User?> signin(String email, String password) async {
    final UserCredential user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return user.user;
  }

  Future<User?> signUp(String email, String password) async {
    final UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }
}

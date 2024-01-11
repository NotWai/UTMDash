// ignore_for_file: avoid_print, unused_element, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:utm_dash/components/cust_snackbar.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/services/f_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object
  UserClass? _userFromFirebaseUser(User? user) {
    return user != null ? UserClass(uid: user.uid) : null;
  }

  //Auth changes stream

  Stream<UserClass?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //with email and pass

  Future signIn(String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await DatabaseService(uid: user!.uid).updateFcmToken(fcmToken);
      }
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      AppSnackBar.showSnackBar(context, 'Error: ${e.message}');
      print(e.toString());
      return null;
    }
  }

  //register

  Future register(String email, String password, String fullName,
      String phoneNumber, BuildContext context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid)
          .createUserData(fullName, phoneNumber, email, 'normal');
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await DatabaseService(uid: user.uid).updateFcmToken(fcmToken);
      }
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      AppSnackBar.showSnackBar(context, 'Error: ${e.message}');
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print("Failed to send password reset email: ${e.message}");
    }
  }
}

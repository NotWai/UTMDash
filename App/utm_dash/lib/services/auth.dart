// ignore_for_file: avoid_print, unused_element

//import 'package:fire1/models/user.dart';
//import 'package:fire1/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object
  //UserClass? _userFromFirebaseUser(User? user) {
  //  return user != null ? UserClass(uid: user.uid) : null;
  //}

  //Auth changes stream

  //Stream<UserClass?> get user {
  //  return _auth.authStateChanges().map(_userFromFirebaseUser);
  //}

  //with email and pass

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register

  Future register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //create document for user
      //await DatabaseService(uid: user!.uid).updateUserData('0', 'New member', 100);
      //return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signout

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

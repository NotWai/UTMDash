
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel{

  final String? uid;
  final String fullname;
  final String phoneNo;
  final String email;
  final String password;

  const UserModel({
    required this.uid,
    required this.fullname,
    required this.phoneNo,
    required this.email,
    required this.password,
  });

  // factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document)
  // {
  //   final data = document.data();
  //   return UserModel(
  //     id: document.id,
  //     email: data[""], 
  //     fullname: fullname, 
  //     password: password,
  //     phoneNo: phoneNo, 
  //     );
  // }
}
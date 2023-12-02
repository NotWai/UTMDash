
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:utm_dash/user_controller.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';


// class UserRepository extends GetxController{

//   final _db = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;


//   Future createUser(UserModel user) async {
//       DocumentSnapshot doc = await _db.collection('Users').doc(user.uid).get();
    
//       if (!doc.exists) {
//         _db.collection('Users').doc(user.uid).set({
//           'Fullname': user.fullname,
//           'Phone': user.phoneNo,
//           'Email': user.email,
//           'Password':user.password, 
//         });
//       }
//     }

//     Future registerNewUser(String email, String password) async {
//       try {
//         UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//           email: email.trim(),
//           password: password,
//         );
//         return userCredential.user;
//       } on FirebaseAuthException catch (e) {
//         // handle error
//       }
//     }

//   // createUser(UserModel user) async {

//   //  await  _db.collection("Users").add(user.toJson()).whenComplete(
//   //     () => Get.snackbar("Success", "Account has been created",
//   //     snackPosition: SnackPosition.BOTTOM,
//   //     backgroundColor:  Colors.green.withOpacity(0.1),
//   //     colorText: Colors.green),

//   //   )

//   //   .catchError((error, StackTrace){
//   //     Get.snackbar("Error", "Something went wrong. Try again",
//   //     snackPosition: SnackPosition.BOTTOM,
//   //     backgroundColor: Colors.redAccent.withOpacity(0.1),
//   //     colorText: Colors.red);
//   //   print(error.toString());
//   // });
//   //   } 


//   }


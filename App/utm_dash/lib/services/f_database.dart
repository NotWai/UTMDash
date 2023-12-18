// ignore_for_file: await_only_futures, non_constant_identifier_names, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utm_dash/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference myCollection =
      FirebaseFirestore.instance.collection('Users');

  // update Function:

  Future updateUserData(
      String fullName, String phoneNumber, String emailAddress, String role) async {
    return await myCollection.doc(uid).set({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'emailAddress': emailAddress,
      'Role': role,
    });
  }

  List<UserObject> _objectFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) {
          final data = doc.data() as Map<String, dynamic>?;

          if (data != null) {
            return UserObject(
              fullName: data['fullName'],
              phoneNumber: data['phoneNumber'],
              emailAddress: data['emailAddress'],
            );
          }
        })
        .whereType<UserObject>()
        .toList();
  }

  //Stream for firestore

  //user object from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;
    return UserData(
      uid: uid,
      fullName: data?['fullName'],
      phoneNumber: data?['phoneNumber'],
      emailAddress: data?['emailAddress'],
    );
  }

  Stream<UserData> get userData {
    return myCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future<String?> fetchedUserRoleFromFirestore() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        return userDoc.data()?['Role'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user role: $e');
      return null;
    }
  }
}

// ignore_for_file: await_only_futures, non_constant_identifier_names, unused_element, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utm_dash/models/parcels.dart';
import 'package:utm_dash/models/user.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference myCollection =
      FirebaseFirestore.instance.collection('Users');

  final CollectionReference parcelsCollection =
      FirebaseFirestore.instance.collection('Parcels');

  // update Function:

  Future updateUserData(String fullName, String phoneNumber,
      String emailAddress, String role) async {
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

  Future<DocumentSnapshot?> trackParcel(String trackingNumber) async {
    try {
      QuerySnapshot querySnapshot = await parcelsCollection
          .where('trackingID', isEqualTo: trackingNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching parcel: $e');
      return null;
    }
  }

  Future<String?> fetchedUserRoleFromFirestore() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

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

  ParcelObject _parcelObjectFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;
    return ParcelObject(
      fromName: data?['fromName'] ?? '',
      runnerID: data?['runnerID'] ?? '',
      arrived: formatTimestamp(data?['arrived']),
      trackingID: data?['trackingID'] ?? '',
    );
  }

  Stream<ParcelObject?> get getLatestParcelForUser {
    return parcelsCollection
        .where('receiverID', isEqualTo: uid)
        .orderBy('arrived', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return _parcelObjectFromSnapshot(snapshot.docs.first);
      } else {
        return null;
      }
    });
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }
}

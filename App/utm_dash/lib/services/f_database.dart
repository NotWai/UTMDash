// ignore_for_file: await_only_futures, non_constant_identifier_names, unused_element, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utm_dash/models/parcels.dart';
import 'package:utm_dash/models/user.dart';
import 'package:intl/intl.dart';
import 'package:utm_dash/API/firebase_api.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  final CollectionReference parcelsCollection =
      FirebaseFirestore.instance.collection('Parcels');

  final CollectionReference deliveryRequestsCollection =
      FirebaseFirestore.instance.collection('DeliveryRequests');

  Future<void> updateFcmToken(String fcmToken) async {
    try {
      await usersCollection.doc(uid).update({'FCMToken': fcmToken});
    } catch (e) {
      print('Error updating FCM token: $e');
    }
  }

  Future updateUserData(String fullName, String phoneNumber) async {
    return await usersCollection.doc(uid).update({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    });
  }

  Future createUserData(String fullName, String phoneNumber,
      String emailAddress, String role) async {
    return await usersCollection.doc(uid).update({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'emailAddress': emailAddress,
      'Role': role,
      'FCMToken': '',
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

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;
    return UserData(
      uid: uid,
      fullName: data?['fullName'],
      phoneNumber: data?['phoneNumber'],
      emailAddress: data?['emailAddress'],
    );
  }

  Stream<UserData> get userDataStream {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future getRunnerDetails(String runnerID) async {
    return await usersCollection
        .doc(runnerID)
        .get()
        .then((value) => value.data());
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
      receiverID: data?['receiverID'] ?? '',
      deadline: formatTimestamp(data?['deadline']),
      status: data?['status'] ?? '',
      docID: snapshot.id,
    );
  }

  Stream<List<ParcelObject>> get getParcelsForUser {
    return parcelsCollection
        .where('receiverID', isEqualTo: uid)
        .orderBy('arrived', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => _parcelObjectFromSnapshot(doc))
          .where((parcel) =>
              parcel.status != 'Delivered' && parcel.status != 'Picked Up')
          .toList();
    });
  }

  Stream<List<ParcelObject>> get getDeliveredParcelsForUser {
    return parcelsCollection
        .where('receiverID', isEqualTo: uid)
        .orderBy('arrived', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => _parcelObjectFromSnapshot(doc))
          .where((parcel) =>
              parcel.status == 'Delivered' || parcel.status == 'Picked Up')
          .toList();
    });
  }

  Stream<List<ParcelObject>> get getDeliveredParcelsForHub {
    return parcelsCollection
        .orderBy('deadline', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => _parcelObjectFromSnapshot(doc))
          .where((parcel) =>
              parcel.status == 'Delivered' || parcel.status == 'Picked Up')
          .toList();
    });
  }

  Stream<List<ParcelObject>> get getPendingParcelsForHub {
    return parcelsCollection
        .orderBy('deadline', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => _parcelObjectFromSnapshot(doc))
          .where((parcel) =>
              parcel.status != 'Delivered' && parcel.status != 'Picked Up')
          .toList();
    });
  }

  Future<ParcelObject?> getParcelDetails(String trackingID) async {
    try {
      final querySnapshot = await parcelsCollection
          .where('trackingID', isEqualTo: trackingID)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      return _parcelObjectFromSnapshot(querySnapshot.docs.first);
    } on FirebaseException catch (e) {
      print("Error fetching parcel details: ${e.message}");
      return null;
    }
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  Timestamp convertDateTimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }

  Future<String?> createParcel(
      String senderName,
      String receiverUid,
      String trackingID,
      String runnerID,
      String status,
      DateTime arrived,
      DateTime dateline) async {
    Timestamp time1 = Timestamp.fromDate(arrived);
    Timestamp time2 = Timestamp.fromDate(dateline);
    try {
      await parcelsCollection.add({
        'fromName': senderName,
        'receiverID': receiverUid,
        'trackingID': trackingID,
        'runnerID': runnerID,
        'status': status,
        'arrived': time1,
        'deadline': time2,
      });
      await addNotification(
          receiverUid, 'We\'ve received a new parcel from $senderName');
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<String?> getUserIdFromPhone(String phone) async {
    try {
      QuerySnapshot querySnapshot =
          await usersCollection.where('phoneNumber', isEqualTo: phone).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      print('Error fetching user ID from phone number: ${e.message}');
      return null;
    }
  }

  Stream<QuerySnapshot> get getParcelStream {
    return parcelsCollection.orderBy('deadline', descending: false).snapshots();
  }

  Future<String?> createDeliveryRequest(
      String receiverID,
      String? runnerID,
      String trackingID,
      DateTime desiredDate,
      String deliveryAddress,
      String notes) async {
    try {
      final querySnapshot = await deliveryRequestsCollection
          .where('trackingID', isEqualTo: trackingID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return 'A delivery request with this tracking ID already exists.';
      }

      await deliveryRequestsCollection.add({
        'receiverID': receiverID,
        'runnerID': runnerID,
        'trackingID': trackingID,
        'status': 'Pending',
        'desiredDate': convertDateTimeToTimestamp(desiredDate),
        'deliveryAddress': deliveryAddress,
        'notes': notes,
      });
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Stream<QuerySnapshot> get getNewRequestsStream {
    return deliveryRequestsCollection
        .where('status', isEqualTo: 'Pending')
        .snapshots();
  }

  Future<String?> acceptDeliveryRequest(
      String docID, String status, String receiverID) async {
    try {
      final receiverDocRef = deliveryRequestsCollection.doc(docID);

      await receiverDocRef.update({
        'status': status,
        'runnerID': uid,
      });

      addNotification(receiverID, 'You have a new delivery offer!');

      final receivedUserDoc = await usersCollection.doc(receiverID).get();

      if (receivedUserDoc.exists) {
        final fcmToken = receivedUserDoc['FCMToken'] as String?;

        if (fcmToken != null) {
          final firebaseAPI = FirebaseAPI();
          await firebaseAPI.sendMessage(
            fcmToken: fcmToken,
            title: 'Delivery Request Accepted',
            body: 'Your delivery request has been accepted by the runner.',
          );
        } else {
          return 'Error: Receiver does not have a valid FCM token.';
        }
      } else {
        return 'Error: Receiver does not exist.';
      }

      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Stream<String?> getRequestedDateStream(String trackingID) {
    return deliveryRequestsCollection
        .where('trackingID', isEqualTo: trackingID)
        .limit(1)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return formatTimestamp(querySnapshot.docs.first['desiredDate']);
      } else {
        return null;
      }
    }).handleError((e) {
      print('Error fetching requested date: $e');
      return null;
    });
  }

  Stream<String?> getRequesteStatusStream(String trackingID) {
    return deliveryRequestsCollection
        .where('trackingID', isEqualTo: trackingID)
        .limit(1)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first['status'] as String?;
      } else {
        return null;
      }
    }).handleError((e) {
      print('Error fetching requested date: $e');
      return null;
    });
  }

  Stream<QuerySnapshot> get getAcceptedRequestsByRunner {
    return deliveryRequestsCollection
        .where('runnerID', isEqualTo: uid)
        .where('status', isEqualTo: 'Accepted by Runner')
        .snapshots();
  }

  Stream<QuerySnapshot> get geDeliveredRequests {
    return deliveryRequestsCollection
        .where('runnerID', isEqualTo: uid)
        .where('status', isEqualTo: 'Done')
        .snapshots();
  }

  Stream<QuerySnapshot> get getAcceptedRequestsByBoth {
    return deliveryRequestsCollection
        .where('runnerID', isEqualTo: uid)
        .where('status', isEqualTo: 'Accepted')
        .snapshots();
  }

  Future<String?> updateDeliveryRequest(String trackingID,
      String deliveryAddress, String notes, DateTime selectedDate) async {
    try {
      final receivedDoc = deliveryRequestsCollection
          .where('trackingID', isEqualTo: trackingID)
          .limit(1)
          .get();
      receivedDoc.then((value) => value.docs.first.reference.update({
            'deliveryAddress': deliveryAddress,
            'notes': notes,
            'desiredDate': convertDateTimeToTimestamp(selectedDate),
            'runnerID': '',
            'status': 'Pending',
          }));
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<String?> deleteDeliveryRequest(String trackingID) async {
    try {
      final receiverDocRef = deliveryRequestsCollection
          .where('trackingID', isEqualTo: trackingID)
          .limit(1)
          .get();

      await receiverDocRef.then((value) => value.docs.first.reference.delete());
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<String?> cancelDeliveryRequest(String trackingID) async {
    try {
      final querySnapshot = await deliveryRequestsCollection
          .where('trackingID', isEqualTo: trackingID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update({
          'status': 'Pending',
          'runnerID': '',
        });
      }
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<String?> acceptDeliveryOffer(String trackingID) async {
    try {
      final querySnapshot = await deliveryRequestsCollection
          .where('trackingID', isEqualTo: trackingID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update({
          'status': 'Accepted',
        });
        updateParcelStatus(trackingID);
      }

      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<String?> doneDeliveryRequest(
      String trackingID, String receiverUid) async {
    try {
      final querySnapshot = await deliveryRequestsCollection
          .where('trackingID', isEqualTo: trackingID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update({
          'status': 'Done',
        });
        await doneParcelStatus(trackingID);
        await addNotification(receiverUid,
            'Delivery request for $trackingID has been completed!');
      }

      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<void> doneParcelStatus(String trackingID) async {
    try {
      final querySnapshot = await parcelsCollection
          .where('trackingID', isEqualTo: trackingID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update({
          'status': 'Delivered',
          'runnerID': uid,
        });
      }

      return;
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<String?> pickedUpParcelStatus(String trackingID) async {
    try {
      final querySnapshot = await parcelsCollection
          .where('trackingID', isEqualTo: trackingID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update({
          'status': 'Picked Up',
          'runnerID': '',
        });
      }

      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<void> updateParcelStatus(String trackingID) async {
    try {
      final querySnapshot = await parcelsCollection
          .where('trackingID', isEqualTo: trackingID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update({
          'status': 'Preparing for delivery',
        });
      }

      return;
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<QueryDocumentSnapshot<Object?>?> getDeliveryRequest(
      String trackingID) async {
    try {
      final querySnapshot = await deliveryRequestsCollection
          .where('trackingID', isEqualTo: trackingID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      print('Error fetching delivery request: ${e.message}');
      return null;
    }
  }

  Future<DocumentSnapshot<Object?>?> fetchRunnerDetails(String runnerID) async {
    try {
      final docRef = await usersCollection.doc(runnerID).get();

      if (docRef.exists) {
        return docRef;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      print('Error fetching delivery request: ${e.message}');
      return null;
    }
  }

  Future<String?> rateRunner(String runnerID, double userRating) async {
    try {
      final docRef = usersCollection.doc(runnerID);

      final runnerDoc = await docRef.get();

      final Map<String, dynamic>? existingRatingMap =
          (runnerDoc.data() as Map<String, dynamic>?)?['rating'];

      int numberOfRatings =
          (existingRatingMap?['numberOfRatings'] as int?) ?? 0;
      double currentAvg = (existingRatingMap?['avg'] as double?) ?? 0.0;

      numberOfRatings++;
      final double newAvg =
          ((currentAvg * (numberOfRatings - 1)) + userRating) / numberOfRatings;

      await docRef.update({
        'rated': true,
        'rating': {
          'avg': newAvg,
          'numberOfRatings': numberOfRatings,
        },
      });

      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<String?> checkRateStatus(String trackingID) async {
    try {
      final querySnapshot = await deliveryRequestsCollection
          .where('trackingID', isEqualTo: trackingID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final documentRef =
            deliveryRequestsCollection.doc(querySnapshot.docs.first.id);
        final documentData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        bool rated = documentData['rated'] ?? false;

        if (!documentData.containsKey('rated')) {
          await documentRef.update({'rated': false});
        }

        return rated ? 'true' : 'false';
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      print('Error checking rate status: ${e.message}');
      return null;
    }
  }

  Future<void> updateRateStatus(String trackingID) async {
    try {
      final querySnapshot = await deliveryRequestsCollection
          .where('trackingID', isEqualTo: trackingID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update({
          'rated': true,
        });
      }
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<Map<String, dynamic>?> getRunnerRating(String runnerID) async {
    try {
      final docRef = usersCollection.doc(runnerID);
      final runnerDoc = await docRef.get();

      if (runnerDoc.exists) {
        final Map<String, dynamic>? existingRatingMap =
            (runnerDoc.data() as Map<String, dynamic>?)?['rating'];

        if (existingRatingMap != null) {
          return existingRatingMap;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      print('Error fetching runner rating: ${e.message}');
      return null;
    }
  }

  String formatDateTime(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final formattedTimestamp = DateFormat('dd MMM, hh:mma').format(dateTime);
    return formattedTimestamp;
  }

  Future<void> addNotification(String userId, String notification) async {
    final userNotificationsRef =
        usersCollection.doc(userId).collection('notifications');

    await userNotificationsRef.add({
      'notification': notification,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? get getNotificationsStream {
    try {
      return usersCollection
          .doc(uid)
          .collection('notifications')
          .orderBy('timestamp', descending: true)
          .snapshots();
    } on FirebaseException catch (e) {
      print('Error fetching notifications: ${e.message}');
      return null;
    }
  }
}

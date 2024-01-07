// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:utm_dash/components/cust_snackbar.dart';
import 'package:utm_dash/services/f_database.dart';

class MyCustomListTile extends StatelessWidget {
  final QueryDocumentSnapshot request;
  final bool accepted;
  final DatabaseService? firestoreAccess;

  const MyCustomListTile({
    Key? key,
    required this.request,
    required this.accepted,
    this.firestoreAccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red[600],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            request['receiverID'],
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            request['trackingID'],
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          trailing: Visibility(
            visible: !accepted,
            child: ElevatedButton(
              onPressed: () async {
                dynamic result = await firestoreAccess?.acceptDeliveryRequest(
                    request.id, 'Accepted by a Runner');
                if (result != null) {
                  AppSnackBar.showSnackBar(context, result);
                } else {
                  // Navigate to another screen
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'Accept',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

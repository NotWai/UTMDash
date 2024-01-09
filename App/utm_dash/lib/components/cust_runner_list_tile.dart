// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:utm_dash/models/parcels.dart';
import 'package:utm_dash/services/f_database.dart';

class MyCustomListTile extends StatelessWidget {
  final QueryDocumentSnapshot request;
  final DatabaseService? firestoreAccess;

  const MyCustomListTile({
    Key? key,
    required this.request,
    this.firestoreAccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ParcelObject?>(
      future: firestoreAccess?.getParcelDetails(request['trackingID']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return const Center(
            child: Text('Error'),
          );
        }
        final parcel = snapshot.data!;
        return FutureBuilder(
          future: DatabaseService(uid: parcel.receiverID).userDataStream.first,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Center(
                child: Text('Error'),
              );
            }
            final receiver = snapshot.data!;
            return Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: MediaQuery.sizeOf(context).height * 0.084,
                  decoration: BoxDecoration(
                    color: const Color(0xFFBE1C2D),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(
                            0.5), 
                        offset: const Offset(0,
                            5),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 5, 20, 5),
                          child: Text(
                            receiver.fullName,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 5, 20, 5),
                          child: Text(
                            parcel.trackingID,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

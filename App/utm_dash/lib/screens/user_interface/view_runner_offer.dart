// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/models/parcels.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/services/f_database.dart';

class ViewRunnerOffer extends StatefulWidget {
  final ParcelObject parcel;
  const ViewRunnerOffer({
    Key? key,
    required this.parcel,
  }) : super(key: key);

  @override
  State<ViewRunnerOffer> createState() => _ViewRunnerOfferState();
}

class _ViewRunnerOfferState extends State<ViewRunnerOffer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass?>(context);
    final firestoreAccess = DatabaseService(uid: user!.uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Delivery'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<QueryDocumentSnapshot<Object?>?>(
                future: firestoreAccess
                    .getDeliveryRequest(widget.parcel.trackingID),
                builder: (context, snapshot) {
                  if (ConnectionState.waiting == snapshot.connectionState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(
                      child: Text('Error fetching data'),
                    );
                  }

                  final request = snapshot.data!;

                  return FutureBuilder(
                    future:
                        firestoreAccess.getRunnerDetails(request['runnerID']),
                    builder: (context, snapshot) {
                      if (ConnectionState.waiting == snapshot.connectionState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError || !snapshot.hasData) {
                        return const Center(
                          child: Text('Error fetching data'),
                        );
                      }
                      final runner = snapshot.data!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery Request',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'From: ${widget.parcel.fromName}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Runner Name: ${runner['fullName']}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Runner phone number: ${runner['phoneNumber']}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Rate: RM${runner['rate']}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

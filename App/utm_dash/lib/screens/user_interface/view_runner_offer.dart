// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/components/cust_snackbar.dart';
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
                          const SizedBox(height: 10),
                          FutureBuilder<Map<String, dynamic>?>(
                            future: firestoreAccess
                                .getRunnerRating(request['runnerID']),
                            builder: (context, snapshot) {
                              if (ConnectionState.waiting ==
                                  snapshot.connectionState) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return const Center(
                                    child: Text('Error fetching data'));
                              }

                              final Map<String, dynamic>? ratingMap =
                                  snapshot.data;

                              if (ratingMap != null) {
                                final double avgRating = ratingMap['avg'];
                                final int numberOfRatings =
                                    ratingMap['numberOfRatings'];

                                return Text(
                                  'Driver Rating: $avgRating (from $numberOfRatings ratings)',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                );
                              } else {
                                return Text(
                                  'Driver Rating: No ratings available yet!',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                          colors: [Colors.red.shade700, Colors.red.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          dynamic result = await firestoreAccess
                              .cancelDeliveryRequest(widget.parcel.trackingID);

                          Navigator.pop(context);

                          if (result == null) {
                            AppSnackBar.showSnackBar(context,
                                'The request has been rejected successfully!',
                                backgroundColor: Colors.green);
                          } else {
                            AppSnackBar.showSnackBar(
                                context, 'Error rejecting request: $result');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Reject',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                          colors: [Colors.red.shade700, Colors.red.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          dynamic result = await firestoreAccess
                              .acceptDeliveryOffer(widget.parcel.trackingID);

                          Navigator.pop(context);

                          if (result == null) {
                            AppSnackBar.showSnackBar(context,
                                'The request has been accepted successfully!',
                                backgroundColor: Colors.green);
                          } else {
                            AppSnackBar.showSnackBar(
                                context, 'Error accepting request: $result');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Accept',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

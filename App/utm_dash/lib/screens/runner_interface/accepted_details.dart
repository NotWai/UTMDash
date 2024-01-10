// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/components/cust_snackbar.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/runner_history.dart';
import 'package:utm_dash/services/f_database.dart';

class AcceptedDetails extends StatefulWidget {
  final QueryDocumentSnapshot request;
  const AcceptedDetails({super.key, required this.request});

  @override
  State<StatefulWidget> createState() => _AcceptedDetailsState();
}

class _AcceptedDetailsState extends State<AcceptedDetails> {
  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }
    final user = Provider.of<UserClass?>(context);
    final firestoreAccess = DatabaseService(uid: user!.uid);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE1C2D),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Accepted Requests',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontFamily: 'Inter',
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          FutureBuilder<UserData>(
            future: DatabaseService(uid: widget.request['receiverID'])
                .userDataStream
                .first,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError || !snapshot.hasData) {
                return const Center(
                  child: Text('Error'),
                );
              }

              final userData = snapshot.data!;

              return Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.550,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 25, 0, 10),
                        child: Text(
                          'Details',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, -1),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20, 10, 20, 10),
                        child: Text(
                          'Tracking number',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontFamily: 'Inter',
                                    color: const Color(0xFFBDC0C0),
                                  ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                        child: Text(
                          widget.request['trackingID'],
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontFamily: 'Inter',
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                      child: Text(
                        'Name',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: 'Inter',
                              color: const Color(0xFFBDC0C0),
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                      child: Text(
                        userData.fullName,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: 'Inter',
                              color: Colors.black,
                            ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, -1),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20, 10, 20, 10),
                        child: Text(
                          'Location',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontFamily: 'Inter',
                                    color: const Color(0xFFBDC0C0),
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                      child: Text(
                        widget.request['deliveryAddress'],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: 'Inter',
                              color: Colors.black,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                      child: Text(
                        'Phone Number',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: 'Inter',
                              color: const Color(0xFFBDC0C0),
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                      child: Text(
                        userData.phoneNumber,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: 'Inter',
                              color: Colors.black,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                      child: Text(
                        'Date ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: 'Inter',
                              color: const Color(0xFFBDC0C0),
                            ),
                      ),
                    ),
                    FutureBuilder<String?>(
                      future: firestoreAccess
                          .getRequestedDateStream(widget.request['trackingID'])
                          .first,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError || !snapshot.hasData) {
                          return const Center(
                            child: Text('Error'),
                          );
                        }
                        final requestedDate = snapshot.data!;

                        return Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 10),
                          child: Text(
                            requestedDate,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontFamily: 'Inter',
                                  color: Colors.black,
                                ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 50, 20, 50),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          dynamic result =
                              await firestoreAccess.doneDeliveryRequest(
                                  widget.request['trackingID']);

                          if (result == null) {
                            AppSnackBar.showSnackBar(context,
                                'Parcel has been updated as delivered!',
                                backgroundColor: Colors.green);
                          } else {
                            AppSnackBar.showSnackBar(
                                context, 'Error updating parcel status!');
                          }

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFFBE1C2D),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.3,
                            MediaQuery.of(context).size.height * 0.05,
                          ),
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24, 0, 24, 0),
                          elevation: 3,
                          side: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Delivered',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

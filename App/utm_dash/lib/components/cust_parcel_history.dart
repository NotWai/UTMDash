import 'package:flutter/material.dart';
import 'package:utm_dash/models/parcels.dart';
import 'package:utm_dash/services/f_database.dart';

class CustomParcelListView extends StatefulWidget {
  final ParcelObject parcel;
  final DatabaseService firestoreAccess;
  const CustomParcelListView({
    super.key,
    required this.firestoreAccess,
    required this.parcel,
  });

  @override
  State<CustomParcelListView> createState() => _CustomParcelListViewState();
}

class _CustomParcelListViewState extends State<CustomParcelListView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ParcelObject>>(
      stream: widget.firestoreAccess.getParcelsForUser,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Container(
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 15,
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.27,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5,
                  color: Color(0x33000000),
                  offset: Offset(1.0, 1.0),
                )
              ],
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: FutureBuilder(
              future: widget.firestoreAccess
                  .getDeliveryRequest(widget.parcel.trackingID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error fetching data'),
                  );
                }
                final deliveryRequest = snapshot.data;

                if (deliveryRequest == null) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(-1, -1),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Parcel Number',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Colors.grey,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1, -1),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 5, 20, 10),
                                child: Text(
                                  widget.parcel.trackingID,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                            const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 420,
                                  child: Divider(
                                    height: 2,
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 00, 0),
                                  child: Text(
                                    'Sender',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.grey,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      190, 0, 20, 0),
                                  child: Text(
                                    'Picked Up',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.grey,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 30, 0),
                                    child: Text(
                                      widget.parcel.fromName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            130, 0, 10, 0),
                                    child: Text(
                                      widget.parcel.deadline,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1, -1),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Parcel Number',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.grey,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1, -1),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 5, 20, 10),
                              child: Text(
                                widget.parcel.trackingID,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 420,
                                child: Divider(
                                  height: 2,
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 00, 0),
                                child: Text(
                                  'Sender',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    190, 0, 20, 0),
                                child: Text(
                                  'Deliverd',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 5, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 30, 0),
                                  child: Text(
                                    widget.parcel.fromName,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      130, 0, 10, 0),
                                  child: Text(
                                    widget.firestoreAccess.formatTimestamp(
                                        deliveryRequest['desiredDate']),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 00, 0),
                                child: Text(
                                  'Runner Name',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    190, 0, 20, 0),
                                child: Text(
                                  'Rating',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 5, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 30, 0),
                                  child: Text(
                                    'Runner Name',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            100, 0, 10, 0),
                                    child: ElevatedButton(
                                      onPressed: () async {},
                                      child: const Text('Rate Runner'),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/screens/hub_interface/hub_add_parcel.dart';
import 'package:utm_dash/models/parcels.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/services/f_database.dart';

class HubHomepage extends StatefulWidget {
  const HubHomepage({super.key});

  @override
  State<HubHomepage> createState() => _HubHomepageState();
}

class _HubHomepageState extends State<HubHomepage> {
  @override
  Widget build(BuildContext context) {
    Widget _buildDetailRow(String label, String value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    final user = Provider.of<UserClass?>(context);
    final firestoreAccess = DatabaseService(uid: user!.uid);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            //width: 393,
            height: 237,
            decoration: const BoxDecoration(
              color: Color(0xFFBE1C2D),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 80, 0, 0),
                        child: Text(
                          'NinjaVan Angkasa',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x33000000),
                              offset: Offset(0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 8, 0),
                                  child: TextFormField(
                                    controller: TextEditingController(),
                                    focusNode: FocusNode(),
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      hintText: 'Search...',
                                      hintStyle: TextStyle(fontSize: 14),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                    style: const TextStyle(fontSize: 16),
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0.9, 0),
                                  child: Icon(
                                    Icons.search_rounded,
                                    color: Colors.black45,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Align(
                  alignment: AlignmentDirectional(-1, -1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 30, 0, 10),
                    child: Text(
                      'Customer Overdue',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: firestoreAccess.getParcelStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final parcels = snapshot.data!.docs;
                    if (snapshot.data == null || parcels.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Text('No parcels yet...'),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: parcels.length,
                        itemBuilder: (context, index) {
                          final parcel = parcels[index];
                          return FutureBuilder(
                            future: DatabaseService(uid: parcel['receiverID'])
                                .userDataStream
                                .first,
                            builder: (context, snapshot) {
                              DateTime deadline = parcel['deadline'].toDate();
                              DateTime currentTime = DateTime.now();
                              int daysDifference =
                                  deadline.difference(currentTime).inDays;
                              String displayText;
                              Color textColor;
                              if (daysDifference < 0) {
                                displayText =
                                    'Passed by ${daysDifference.abs()} days';
                                textColor = Colors.red;
                              } else {
                                displayText = 'Remaining: $daysDifference days';
                                textColor = Colors.black;
                              }
                              UserData? userData = snapshot.data;
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  userData == null) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 10),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.white60,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    ParcelObject? parcelObj =
                                        await DatabaseService(uid: '')
                                            .getParcelDetails(
                                                parcel['trackingID']);

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          elevation: 10.0,
                                          backgroundColor: Colors.white,
                                          child: SizedBox(
                                            width: 500.0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  _buildDetailRow(
                                                      'Customer Name',
                                                      userData.fullName),
                                                  const SizedBox(height: 10.0),
                                                  _buildDetailRow(
                                                      'Customer Email',
                                                      userData.emailAddress),
                                                  const SizedBox(height: 10.0),
                                                  _buildDetailRow(
                                                      "Phone number",
                                                      userData.phoneNumber),
                                                  const SizedBox(height: 10.0),
                                                  _buildDetailRow('Arrived',
                                                      parcelObj?.arrived ?? ''),
                                                  const SizedBox(height: 10.0),
                                                  _buildDetailRow(
                                                      'Dateline',
                                                      parcelObj?.deadline ??
                                                          ''),
                                                  const SizedBox(height: 10.0),
                                                  _buildDetailRow(
                                                      'Tracking Number',
                                                      parcelObj?.trackingID ??
                                                          ''),
                                                  const SizedBox(height: 20.0),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {},
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'Received By Hand',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width: 10.0),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // Close the dialog
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'Close',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 3,
                                          color: Color(0x33000000),
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                userData.fullName,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 7),
                                              Flexible(
                                                child: Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          1, 0),
                                                  child: Text(
                                                    displayText,
                                                    style: TextStyle(
                                                      color: textColor,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 11),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                userData.phoneNumber,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 7),
                                              Flexible(
                                                child: Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          1, 0),
                                                  child: Text(
                                                    parcel['trackingID'],
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     print('Button pressed ...');
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: const Color(0xFFBE1C2D),
                //     padding: const EdgeInsets.symmetric(horizontal: 24),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(6),
                //     ),
                //     minimumSize: const Size(120, 45),
                //   ),
                //   child: const Text(
                //     'View Record',
                //     style: TextStyle(
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HubAddParcel()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBE1C2D),
                    padding: const EdgeInsets.all(16),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

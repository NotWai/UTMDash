// ignore_for_file: avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:utm_dash/components/cust_snackbar.dart';
import 'package:utm_dash/models/parcels.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/screens/user_interface/request_delivery.dart';
import 'package:utm_dash/services/f_database.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final TextEditingController trackController = TextEditingController();
  final PageController pageViewController = PageController();
  final _formkey = GlobalKey<FormState>();

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
              fontSize: 16,
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
                    fontSize: 16,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Form(
              key: _formkey,
              child: Container(
                //width: 393,
                height: 333,
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
                    const Align(
                      alignment: AlignmentDirectional(-1, -1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 50, 0, 0),
                        child: Text(
                          'Track Parcel',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: AlignmentDirectional(-1, -1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 30, 0, 10),
                        child: Text(
                          'Enter parcel number',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                      child: TextFormField(
                        controller: trackController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a tracking number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                          hintText: 'tracking number',
                          hintStyle:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: Color(0xFFACACAC),
                          ),
                        ),
                        cursorColor: const Color(0xFFBE1C2D),
                        style: Theme.of(context).textTheme.bodyMedium!.merge(
                              const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 25, 20, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            ParcelObject? parcel = await firestoreAccess
                                .getParcelDetails(trackController.text.trim());
                            if (parcel != null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 10.0,
                                    backgroundColor: Colors.white,
                                    child: SizedBox(
                                      width: 300.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _buildDetailRow(
                                                'From', parcel.fromName),
                                            const SizedBox(height: 10.0),
                                            _buildDetailRow('Tracking ID',
                                                parcel.trackingID),
                                            const SizedBox(height: 10.0),
                                            _buildDetailRow(
                                                'Arrived in', parcel.arrived),
                                            const SizedBox(height: 10.0),
                                            _buildDetailRow(
                                                'Dateline', parcel.deadline),
                                            const SizedBox(height: 10.0),
                                            _buildDetailRow(
                                                'Status', parcel.status),
                                            const SizedBox(height: 20.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            RequestDeliveryPage(
                                                                parcel: parcel),
                                                      ),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Request Runner',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(width: 10.0),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Close',
                                                    style: TextStyle(
                                                        color: Colors.white),
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
                            } else {
                              AppSnackBar.showSnackBar(context,
                                  'There is no parcel with that Tracking ID is registered yet!');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24, 0, 24, 0),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.06,
                          alignment: Alignment.center,
                          child: const Text(
                            'Track Parcel',
                            style: TextStyle(
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
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.9,
                height: MediaQuery.sizeOf(context).height * 0.3,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 40),
                      child: PageView(
                        controller: pageViewController,
                        scrollDirection: Axis.horizontal,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/Runner_ads.png',
                              width: 300,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/NinjaVan_ads.png',
                              width: 300,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0, 1),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 16),
                        child: smooth_page_indicator.SmoothPageIndicator(
                          controller: pageViewController,
                          count: 2,
                          axisDirection: Axis.horizontal,
                          onDotClicked: (int i) async {
                            await pageViewController.animateToPage(
                              i,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          effect:
                              const smooth_page_indicator.ExpandingDotsEffect(
                            expansionFactor: 3,
                            spacing: 8,
                            radius: 16,
                            dotWidth: 16,
                            dotHeight: 8,
                            dotColor: Color(0xFFACACAC),
                            activeDotColor: Colors.black,
                            paintStyle: PaintingStyle.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional(-1, -1),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 5, 0, 10),
                child: Text(
                  'Important',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 15),
              child: Container(
                width: 393,
                height: 130,
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
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, -1),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            'Runner Service Rate',
                            style: TextStyle(
                              color: Color(0xFFBE1C2D),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, -1),
                        child: Text('Parcel Fee / each - RM1.00'),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, -1),
                        child: Text('Runner Service Fee - RM2.00'),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, -1),
                        child: Text('Total = Parcel Fee + Runner Service Fee'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 15),
              child: Container(
                width: 393,
                height: 320,
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1, -1),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'NinjaVan Angkasa Service',
                                  style: TextStyle(
                                    color: Color(0xFFBE1C2D),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1, -1),
                              child: Text('Shipping Service Available'),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1, -1),
                              child: Text(
                                  'Location: Arked Angkasa, KTDI, UTM Skudai, 80990 Johor Bahru, Johor'),
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/Parcel_Details.png',
                          width: 300,
                          height: 167,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/services/f_database.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({Key? key}) : super(key: key);

  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController textController;
  late FocusNode textFieldFocusNode;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    textFieldFocusNode = FocusNode();
  }

  @override
  void dispose() {
    textController.dispose();
    textFieldFocusNode.dispose();

    super.dispose();
  }

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

    final buttonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      minimumSize: const Size(double.infinity, 40),
    );

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.430,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 50, 0, 0),
                          child: Text(
                            'Track Parcel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                          child: Text(
                            'Enter parcel number',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Tracking number',
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            suffixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                color: Colors
                                    .black,
                                width: 2.0, 
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 30, 20, 20),
                          child: ElevatedButton(
                            onPressed: () {
                              _onTrackParcelPressed();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(double.infinity, 50)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Track Parcel',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //!Till here code is working 
            Align(
              alignment: const AlignmentDirectional(1, 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: AspectRatio(
                      aspectRatio: 2.0,
                      child: Image.asset(
                        'assets/images/Runner_ads.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Container(
                      width: 460,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      alignment: const AlignmentDirectional(0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                                  child: Text(
                                    'My Parcels',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontFamily: 'Inter',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 5),
                                child: Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height * 0.19,
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
                                  child: Column(
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
                                                child: Text(
                                                  'Parcel Number',
                                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(-1, -1),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                  10, 5, 20, 10),
                                                child: Text(
                                                  'MYNJV0037604130',
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
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
                                                    'Runner',
                                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                                    190, 0, 20, 0),
                                                  child: Text(
                                                    'Arrived',
                                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                                                      'Farid Azri',
                                                      style: Theme.of(context).textTheme.bodyMedium,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                                      130, 0, 10, 0),
                                                    child: Text(
                                                      '10 Dec 2023',
                                                      style: Theme.of(context).textTheme.bodyMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 50, 20, 20),
                      child: ElevatedButton(
                        onPressed: () {
                          _onRequestRunnerPressed();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFBE1C2D)),
                          minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                            ),
                          ),
                        ),
                        child: Text(
                          'Request to Be Runner',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
          ],
        ),
      ),
    );
  }

  void _onTrackParcelPressed() {
    print('Track Parcel button pressed ...');
  }

  void _onRequestRunnerPressed() {
    print('Request Runner button pressed ...');
  }
}

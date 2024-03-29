// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/screens/hub_interface/hub_view_record.dart';
import 'package:utm_dash/screens/profile/edit_profile.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/screens/runner_interface/runner_history.dart';
import 'package:utm_dash/screens/user_interface/parcels_history.dart';
import 'package:utm_dash/services/auth.dart';
import 'package:utm_dash/services/f_database.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass>(context, listen: false);
    final firestoreAccess = DatabaseService(uid: user.uid);
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: const AlignmentDirectional(-1.00, -1.02),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
            child: Container(
              //width: 403,
              height: 98,
              decoration: const BoxDecoration(
                color: Color(0xFFBE1C2D),
              ),
              child: const Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: Text('Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0.00, 0.00),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.00, 0.00),
                  child: Container(
                    width: 100,
                    height: 100,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    // child: Image.network(
                    //   "https://www.shutterstock.com/image-vector/blank-avatar-photo-place-holder-600nw-1095249842.jpg",
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
        StreamBuilder(
          stream: firestoreAccess.userDataStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Text('Error 404');
            } else {
              UserData? data = snapshot.data;
              return Column(
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.00, 0.00),
                    child: Text(data?.fullName ?? 'Loading...',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.00, 0.00),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 16),
                      child: Text(
                        data?.emailAddress ?? 'Loading...',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
          child: Text(
            'Your Account',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EditProfile()));
            },
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 3,
                    color: Color(0x33000000),
                    offset: Offset(0, 1),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {},
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        Icons.account_circle_outlined,
                        color: Color.fromRGBO(90, 92, 96, 1),
                        size: 24,
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: Color.fromRGBO(90, 92, 96, 1),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: const AlignmentDirectional(0.90, 0.00),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfile()));
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Color.fromRGBO(90, 92, 96, 1),
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 3,
                  color: Color(0x33000000),
                  offset: Offset(0, 1),
                )
              ],
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(
                    Icons.history,
                    color: Color.fromRGBO(90, 92, 96, 1),
                    size: 24,
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Text(
                      'View History',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Color.fromRGBO(90, 92, 96, 1),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: const AlignmentDirectional(0.90, 0.00),
                      child: GestureDetector(
                        onTap: () async {
                          dynamic result = await firestoreAccess
                              .fetchedUserRoleFromFirestore();
                          if (result == 'normal') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserParcelsHistory()));
                          } else if (result == 'Runner') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RunnerHistory()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ViewRecordHub()));
                          }
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromRGBO(90, 92, 96, 1),
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 16, 0, 0),
          child: Text(
            'App Settings',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
              color: Color.fromRGBO(90, 92, 96, 1),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 3,
                  color: Color(0x33000000),
                  offset: Offset(0, 1),
                )
              ],
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
            ),
            child: const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.help_outline_rounded,
                    color: Color.fromRGBO(90, 92, 96, 1),
                    size: 24,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Text(
                      'Support',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Color.fromRGBO(90, 92, 96, 1),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0.90, 0.00),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromRGBO(90, 92, 96, 1),
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 3,
                  color: Color(0x33000000),
                  offset: Offset(0, 1),
                )
              ],
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
            ),
            child: const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.privacy_tip_rounded,
                    color: Color.fromRGBO(90, 92, 96, 1),
                    size: 24,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Text(
                      'Terms of Service',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Color.fromRGBO(90, 92, 96, 1),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0.90, 0.00),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromRGBO(90, 92, 96, 1),
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0.00, 0.00),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
            child: ElevatedButton(
                onPressed: () async {
                  _auth.signOut();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBE1C2D),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(38),
                  ),
                ),
                child: Container(
                  width: 150,
                  height: 44,
                  alignment: Alignment.center,
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
          ),
        ),
      ],
    )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/components/cust_parcel_list.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/services/f_database.dart';

class UserParcelsActivity extends StatefulWidget {
  const UserParcelsActivity({super.key});

  @override
  State<UserParcelsActivity> createState() => _UserParcelsActivityState();
}

class _UserParcelsActivityState extends State<UserParcelsActivity> {
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
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE1C2D),
        automaticallyImplyLeading: false,
        title: Text(
          'Activity ',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontFamily: 'Readex Pro',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
        child: Column(
          children: [
            Align(
              alignment: const AlignmentDirectional(-1, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                child: Text(
                  'My Parcels',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Inter',
                        fontSize: 18,
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: CustomParcelListView(
                firestoreAccess: firestoreAccess,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

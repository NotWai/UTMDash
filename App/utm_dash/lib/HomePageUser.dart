// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/models/user.dart';

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
    trackParcelList();
  }

  @override
  void dispose() {
    // Dispose of any resources if needed.
    textController.dispose();
    textFieldFocusNode.dispose();

    super.dispose();
  }

  Future<void> trackParcel(String trackingNumber) async {
    // TODO: Fetch parcel data from Firebase based on trackingNumber
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection("Parcels")
          .where("trackingID", isEqualTo: trackingNumber)
          .get();
      var docs = snapshot.docs;

      if (docs.isNotEmpty) {
        // Parcel found, you can access data using snapshot.data()

        // Check if alr not exist in user profile
        final user = Provider.of<UserClass>(context, listen: false);
        final userRef =
            FirebaseFirestore.instance.collection('Users').doc(user.uid);
        final userData = await userRef.get();
        try {
          final trackingList = userData.get('trackingId') as List;

          if (trackingList.contains(trackingNumber)) {
            print('Parcel already exists in profile');
            return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Parcel Details'),
                  content: const Text('Your parcel already arrived.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the pop-up
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        } catch (e) {
          print('Error fetching parcel data: $e');
        }

        // Insert into user profile
        await userRef.update({
          'trackingId': FieldValue.arrayUnion([trackingNumber])
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Parcel Details'),
              content: Text(
                  'Parcel data:\nArrived: ${docs.first.get("arrived")}\nFrom: ${docs.first.get("fromName")}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the pop-up
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );

        setState(() {
          // Update your widget's state with the fetched data if needed
          // Example: parcelData = snapshot.data();
        });
      } else {
        print('Parcel not found');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Parcel Not Found'),
              content:
                  const Text('No parcel found with the given tracking number.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the pop-up
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error fetching parcel data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> trackParcelList() async {
    try {
      // Check if alr not exist in user profile
      final user = Provider.of<UserClass>(context, listen: false);
      final userRef =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);
      final userData = await userRef.get();

      if (userData.exists) {
        try {
          // Get list tracking id
          final trackingList = userData.get('trackingId') as List<String>;
          // Get user tracking list
          if (trackingList.isNotEmpty) {
            var snapshot = await FirebaseFirestore.instance
                .collection("Parcels")
                .where("trackingID", whereIn: trackingList)
                .get();
            var docs = snapshot.docs;

            if (docs.isNotEmpty) {
              print('done');
              final docList =
                  docs.map((element) => element.data() ?? {}).toList();
              print(docList);
              return docList;
            } else {
              return [];
            }
          } else {
            // Handle the case where the 'trackingId' field is empty
            return [];
          }
        } catch (e) {
          print('Error fetching parcel data: $e');
          return [];
        }
      } else {
        // Handle the case where the user document does not exist
        return [];
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return [];
    }
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.45,
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
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 80, 0, 0),
                    child: Text(
                      'Track Parcel',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.00, 0.00),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                      child: Text(
                        'Enter parcel number',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        // Navigate to P6EditProfilePage
                        // context.pushNamed('P6EditProfilePage');
                        await trackParcel(textController.text);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              12, 12, 12, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 8, 0),
                                  child: TextFormField(
                                    controller: textController,
                                    focusNode: textFieldFocusNode,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: '',
                                      labelStyle: Theme.of(context)
                                          .inputDecorationTheme
                                          .labelStyle,
                                      hintStyle: Theme.of(context)
                                          .inputDecorationTheme
                                          .labelStyle,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    // validator: _model.textControllerValidator.asValidator(context),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      8), // Add some space between TextFormField and Icon
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  // Navigate to P6EditProfilePage
                                  // context.pushNamed('P6EditProfilePage');
                                },
                                child: Icon(
                                  Icons.search_rounded,
                                  color: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .color,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 35, 20, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        trackParcel(textController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            50, 20, 50, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Track Parcel',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 222, 54, 42),
                            Color.fromARGB(255, 255, 87, 65)
                          ], // Change gradient colors as needed
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text(
                        'Request to be a driver',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Text(
                              'My Parcels',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          'Parcel Number',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .color,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          'MYNJV00376041305',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 100),
                                        child: Text(
                                          'Done',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: Colors.green,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  indent: 10,
                                  endIndent: 10,
                                  color: Color(0x9B5A5C60),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'From',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .color,
                                                  ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Text(
                                                'Akmal',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 100),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Arrived',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .color,
                                                  ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Text(
                                                'Tue, 20 September 2023',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
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
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 222, 54, 42),
                            Color.fromARGB(255, 255, 87, 65)
                          ], // Change gradient colors as needed
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text(
                        'Request a driver now!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
                content: Text('Your parcel already arrived.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the pop-up
                    },
                    child: Text('OK'),
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
            content: Text('Parcel data:\nArrived: ${docs.first.get("arrived")}\nFrom: ${docs.first.get("fromName")}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the pop-up
                },
                child: Text('OK'),
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
            content: Text('No parcel found with the given tracking number.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the pop-up
                },
                child: Text('OK'),
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
   try { // Check if alr not exist in user profile
    final user = Provider.of<UserClass>(context, listen: false);
    final userRef = FirebaseFirestore.instance.collection('Users').doc(user.uid);
    final userData = await userRef.get();

    if(userData.exists) {
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
        final docList = docs.map((element) => element.data() ?? {}).toList();
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
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.45,
              decoration: BoxDecoration(
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
                    padding: EdgeInsetsDirectional.fromSTEB(20, 80, 0, 0),
                    child: Text(
                      'Track Parcel',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1.00, 0.00),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                      child: Text(
                        'Enter parcel number',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
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
                          boxShadow: [
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
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
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
                                        Theme.of(context).textTheme.bodyText1,
                                    // validator: _model.textControllerValidator.asValidator(context),
                                  ),
                                ),
                              ),
                              SizedBox(
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
                    padding: EdgeInsetsDirectional.fromSTEB(20, 35, 20, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        trackParcel(textController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsetsDirectional.fromSTEB(50, 20, 50, 20),
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
            Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.00, -1.00),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                      child: Text(
                        'My Parcels',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Container(
                      //width: 400,
                      height: 153,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 0, 0),
                                child: Text(
                                  'Parcel Number',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .color,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Text(
                                    'MYNJV00376041305',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.00, 0.00),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        100, 0, 0, 0),
                                    child: Text(
                                      'Done',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.green,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                            color: Color(0x9B5A5C60),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'From',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .color,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 0),
                                      child: Text(
                                        'Akmal',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    100, 0, 20, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Arrived',
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .color,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 0),
                                      child: Text(
                                        'Tue, 20 September 2023',
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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
}

_HomePageUserState createModel(BuildContext context, Function builder) {
  return _HomePageUserState();
}

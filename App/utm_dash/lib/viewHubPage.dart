// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:utm_dash/HubLoginPage.dart';
// import 'logParcelHub.dart';

// class ViewHubPage extends StatefulWidget {
//   const ViewHubPage({Key? key}) : super(key: key);

//   @override
//   _ViewHubPageState createState() => _ViewHubPageState();
// }

// class _ViewHubPageState extends State<ViewHubPage> {
//   late Color myColor = Color(0xFFBE1C2D);
//   late Size mediaSize = MediaQuery.of(context).size;
//   late List<Map<String, String>> boxLog;

//   @override
//   Widget build(BuildContext context) {
//    boxLog = [
//       {
//         'name': 'Farhana Binti Ayub',
//         'last_tracking_num': '4567',
//         'destination': 'ANGKASA - Block UA1, K9',
//         'date': '18 Oct 2023 16:00',
//         'fee': '+RM 4.00',
//       },
//       {
//         'name': 'Suhaila Binti Amin',
//         'last_tracking_num': '8876',
//         'destination': 'ANGKASA - Block S14, KTC',
//         'date': '18 Oct 2023 14:00',
//         'fee': '+RM 3.00',
//       },
//       {
//         'name': 'Armin Bin Erwin',
//         'last_tracking_num': '8942',
//         'destination': 'ANGKASA - Block H12, KTF',
//         'date': '18 Oct 2023 9:00',
//         'fee': '+RM 1.00',
//       },
//       {
//         'name': 'Zaid Bin Samad',
//         'last_tracking_num': '0937',
//         'destination': 'ANGKASA - Block UA1, K9',
//         'date': '18 Oct 2023 16:00',
//         'fee': '+RM 4.00',
//       },
//       {
//         'name': 'Usman Bin Zain',
//         'last_tracking_num': '4689',
//         'destination': 'ANGKASA - Block H12, KTF',
//         'date': '18 Oct 2023 9:00',
//         'fee': '+RM 1.00',
//       },
//       {
//         'name': 'Ruhaina Binti Masli',
//         'last_tracking_num': '0965',
//         'destination': 'ANGKASA - Block S14, KTC',
//         'date': '18 Oct 2023 14:00',
//         'fee': '+RM 3.00',
//       },
//       {
//         'name': 'Adam Bin Zakaria',
//         'last_tracking_num': '8743',
//         'destination': 'ANGKASA - Block H12, KTF',
//         'date': '18 Oct 2023 9:00',
//         'fee': '+RM 1.00',
//       },
//     ];

//     return Container(
//       decoration: BoxDecoration(
//         color: myColor,
//         image: DecorationImage(
//           image: const AssetImage("assets/images/bg.png"),
//           fit: BoxFit.cover,
//           colorFilter: ColorFilter.mode(
//             myColor.withOpacity(0.2),
//             BlendMode.dstATop,
//           ),
//         ),
//       ),
// child: Scaffold(
//   backgroundColor: myColor,
//   appBar: AppBar(
//     title: const Text(
//       'Logout',
//       style: TextStyle(color: Colors.white),
//     ),
//     backgroundColor: myColor,
//     elevation: 0, // Remove elevation
//     leading: Row(
//       children: <Widget>[
//         IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(
//                 context); // Navigate back to the previous screen
//           },
//         ),
//               // Expanded(
//               //     child: Text(
//               //       "Logout",
//               //       overflow: TextOverflow.ellipsis,
//               //       style: TextStyle(
//               //     color: Colors.white,
//               //   ),
//               //     ),
//               //   ),
//             ],
//           ),
//         ),
//         // body: Stack(
//         //   children: [
//         //     Positioned(top: 80, child: _buildTop()),
//         //     Positioned(bottom: 0, child: _buildBottom()),
//         //   ],
//         // ),
//       ),
//     );
//   }

//   Widget _buildTop() {
//     return SizedBox(
//       width: mediaSize.width,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Transform.translate(
//             offset: Offset(0, -160),
//             child: Image.asset(
//               "assets/images/UTMDASH_LOGO.png",
//               height: 400,
//               width: 400,
//             ),
//           ),
//           Transform.translate(
//               offset: Offset(0, -280),
//               child: Text(
//                 'PARCEL HUB',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w900,
//                   color: Colors.red[50],
//                 ),
//               )),
//           Transform.translate(
//             offset: const Offset(-130, -240),
//             child: SizedBox(
//               width: 80,
//               height: 50,
//               child: Card(
//                 shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(25),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(10.0),
//                   child: Text("   LOG",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w900,
//                         color: myColor,
//                       )),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottom() {
//     return SizedBox(
//       width: mediaSize.width,
//       child: Card(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(30.0),
//            child: ListView(
//             scrollDirection: Axis.vertical,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(left: 37, top: 23, bottom: 5),
//                 child: Text(
//                   'Available Requests',
//                   style: TextStyle(
//                     fontFamily: 'Grotesco',
//                     fontSize: 23,
//                     color: Color.fromARGB(255, 255, 255, 255),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               for (var data in boxLog) logDetails(data),
//             ],
//           ),

//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'logParcelHub.dart';
import 'parcelHubProfilePage.dart';
import 'HomePage.dart';

class ViewHubPage extends StatefulWidget {
  const ViewHubPage({super.key});

  @override
  _ViewHubPageState createState() => _ViewHubPageState();
}

class _ViewHubPageState extends State<ViewHubPage> {

  int currentindex = 0;
  late Color myColor = Color(0xFFBE1C2D);
  late Size mediaSize;
  late List<Map<String, String>> boxLog;

  //  final List<Widget> _widgetOptions = <Widget>[
  //    ViewHubPage(),
  //    parcelHubProfilePage(),
  // ];


  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;

    boxLog = [
      {
        'time': '18 Oct 2023 14:00',
        'contact_no': '0143678821',
        'last_tracking_num': '4567',
        'status': 'Successful',
      },
      {
        'time': '18 Oct 2023 13:04',
        'contact_no': '0177658976',
        'last_tracking_num': '7689',
        'status': 'Successful',
      },
      {
        'time': '18 Oct 2023 13:01',
        'contact_no': '0116676654',
        'last_tracking_num': '4687',
        'status': 'Successful',
      },
      {
        'time': '18 Oct 2023 12:07',
        'contact_no': '0178890066',
        'last_tracking_num': '9807',
        'status': 'Successful',
      },
      {
        'time': '18 Oct 2023 12:05',
        'contact_no': '0125674423',
        'last_tracking_num': '7724',
        'status': 'Successful',
      },
      {
        'time': '18 Oct 2023 12:01',
        'contact_no': '0112564758',
        'last_tracking_num': '4567',
        'status': 'Successful',
      },
      {
        'time': '18 Oct 2023 11:50',
        'contact_no': '0198764432',
        'last_tracking_num': '4567',
        'status': 'Successful',
      },
    ];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 37, top: 23, bottom: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.translate(
                      offset: Offset(-20, -50),
                      child: Image.asset(
                        "assets/images/UTMDASH_LOGO.png",
                        height: 400,
                        width: 400,
                      ),
                    ),
                    Transform.translate(
                        offset: Offset(-20, -170),
                        child: Text(
                          'PARCEL HUB',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.red[50],
                          ),
                        )),
                    Transform.translate(
                        offset: const Offset(-15, -120),
                        child: SizedBox(
                            width: 350,
                            height: 60,
                            child: Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      // crossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(left: 4),
                                              child:
                                                  Icon(Icons.search, size: 22),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Find user by contact number",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ))))),
                    Transform.translate(
                        offset: const Offset(-150, 0),
                        child: SizedBox(
                            width: 80,
                            height: 50,
                            child: Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "   LOG",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: myColor,
                                    ),
                                  ),
                                )))),
                  ],
                ),
              ),
              for (var data in boxLog) logDetails(data)
            ],
          ),
          backgroundColor: myColor,
          appBar: AppBar(
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: myColor,
            elevation: 0,
            leading: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                     Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage())); // Navigate back to the previous screen
                  },
                ),
              ],
            ),
          ),

          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 201, 193, 193),
            type: BottomNavigationBarType.fixed,
            fixedColor: myColor,
            iconSize: 30,
            currentIndex: 0,
            onTap: (value) {
              setState((){
              currentindex = value;
              if(currentindex == 1)
              {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => parcelHubProfilePage()));
              }
              else
              {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewHubPage()));

              }

              });

            },
            items: const[
              BottomNavigationBarItem(backgroundColor: Color.fromARGB(255, 201, 193, 193), icon: Icon(Icons.home),label: 'HOME'),
              BottomNavigationBarItem(backgroundColor: Color.fromARGB(255, 201, 193, 193), icon: Icon(Icons.person), label: 'PROFILE'),
            ]
          ),

        ));
  }
}

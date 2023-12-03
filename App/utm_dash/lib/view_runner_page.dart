// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:utm_dash/signup.dart';
import 'request_box.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final ValueNotifier<bool> isAccepted = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> boxData = [
      {
        'name': 'Farhana Binti Ayub',
        'last_tracking_num': '4567',
        'destination': 'ANGKASA - Block UA1, K9',
        'date': '18 Oct 2023 16:00',
        'fee': '+RM 4.00',
      },
      {
        'name': 'Suhaila Binti Amin',
        'last_tracking_num': '8876',
        'destination': 'ANGKASA - Block S14, KTC',
        'date': '18 Oct 2023 14:00',
        'fee': '+RM 3.00',
      },
      {
        'name': 'Armin Bin Erwin',
        'last_tracking_num': '8942',
        'destination': 'ANGKASA - Block H12, KTF',
        'date': '18 Oct 2023 9:00',
        'fee': '+RM 1.00',
      },
      {
        'name': 'Zaid Bin Samad',
        'last_tracking_num': '0937',
        'destination': 'ANGKASA - Block UA1, K9',
        'date': '18 Oct 2023 16:00',
        'fee': '+RM 4.00',
      },
      {
        'name': 'Usman Bin Zain',
        'last_tracking_num': '4689',
        'destination': 'ANGKASA - Block H12, KTF',
        'date': '18 Oct 2023 9:00',
        'fee': '+RM 1.00',
      },
      {
        'name': 'Ruhaina Binti Masli',
        'last_tracking_num': '0965',
        'destination': 'ANGKASA - Block S14, KTC',
        'date': '18 Oct 2023 14:00',
        'fee': '+RM 3.00',
      },
      {
        'name': 'Adam Bin Zakaria',
        'last_tracking_num': '8743',
        'destination': 'ANGKASA - Block H12, KTF',
        'date': '18 Oct 2023 9:00',
        'fee': '+RM 1.00',
      },
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: Container(
        color: Colors.red[800],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: GNav(
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.red.shade400,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                gap: 8,
                icon: Icons.home,
                text: 'Home',
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
              ),
              GButton(
                gap: 8,
                icon: Icons.notifications,
                text: 'Notifications',
              ),
              GButton(
                gap: 8,
                icon: Icons.person_2,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 37, top: 23, bottom: 5),
              child: Text(
                'Available Requests',
                style: TextStyle(
                    fontFamily: 'Grotesco',
                    fontSize: 23,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w500),
              ),
            ),
            for (var data in boxData) RequestBox(data, context, isAccepted),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 212, 174, 174),
        appBar: AppBar(
          elevation: 0,
          title: const Center(
            child: Text(
              'UTMDash',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 26,
                  fontWeight: FontWeight.w900),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 194, 94, 94),
        ),
      ),
    );
  }
}

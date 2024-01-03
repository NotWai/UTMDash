// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:utm_dash/screens/hub_interface/hub_homepage.dart';
import 'package:utm_dash/screens/profile/profile_screen.dart';

class HubWrapper extends StatefulWidget {
  const HubWrapper({Key? key});

  @override
  State<HubWrapper> createState() => _HubWrapperState();
}

class _HubWrapperState extends State<HubWrapper> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      HubHomepage(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        color: Colors.red[800],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: GNav(
            selectedIndex: currentIndex,
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.red.shade400,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                margin: EdgeInsets.only(left: 40),
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                margin: EdgeInsets.only(right: 40),
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


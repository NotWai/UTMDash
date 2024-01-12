// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:utm_dash/screens/profile/profile_screen.dart';
import 'package:utm_dash/screens/runner_interface/requests_page.dart';
import 'package:utm_dash/screens/runner_interface/runner_delivery.dart';
import 'package:utm_dash/screens/runner_interface/runner_homepage.dart';

class RunnerWrapper extends StatefulWidget {
  const RunnerWrapper({Key? key});

  @override
  State<RunnerWrapper> createState() => _RunnerWrapperState();
}

class _RunnerWrapperState extends State<RunnerWrapper> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      RunnerHomepage(),
      AcceptedRequestsPage(),
      RunnerDeliveryPage(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        color: Color(0xFFBE1C2D),
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
                gap: 8,
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                gap: 8,
                icon: Icons.request_page,
                text: 'Requests',
              ),
              GButton(
                gap: 8,
                icon: Icons.delivery_dining_rounded,
                text: 'Delivery',
              ),
              GButton(
                gap: 8,
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

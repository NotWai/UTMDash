// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:utm_dash/screens/profile/profile_screen.dart';
import 'package:utm_dash/signup.dart';

class CustomerPage extends StatefulWidget {
  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<String> notifications = [
    "Notification 1: Your package has been delivered.",
    "Notification 2: Upcoming delivery schedule change.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
    "Notification 3: Special offer on shipping rates.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notifications',),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFBE1C2D),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationCard(notification: notifications[index]);
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFBE1C2D),
                shape: const StadiumBorder(),
                elevation: 20,
                shadowColor: Colors.black,
                minimumSize: const Size.fromHeight(50),
              ),
              child: Text(
                'Request runner',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 90),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String notification;

  NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(
          notification,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});
  @override
  Size get preferredSize =>
      Size.fromHeight(74.0); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Notifications',
        style: TextStyle(
          color: Colors.white, // Set the text color to white
          fontWeight: FontWeight.bold, // Make the text bold
        ),
      ),
      centerTitle: true,
      backgroundColor: Color(0xFFBE1C2D),
    );
  }
}

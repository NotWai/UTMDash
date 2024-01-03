// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:utm_dash/screens/auth/HomePage.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/screens/hub_wrapper.dart';
import 'package:utm_dash/screens/runner_wrapper.dart';
import 'package:utm_dash/services/f_database.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/screens/customer_wrapper.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass?>(context);
    print(user);
    if (user == null) {
      return const HomePage();
    } else {
      return FutureBuilder<String?>(
        future: DatabaseService(uid: user.uid).fetchedUserRoleFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              // Handle errors in fetching user role
              return const Text('Error fetching user role');
            } else {
              String? userRole = snapshot.data;

              if (userRole != null) {
                if (userRole == 'normal') {
                  return const CustomerWrapper();
                } else if (userRole == 'Hub') {
                  return const HubWrapper();
                } else if (userRole == 'Runner') {
                  return const RunnerWrapper();
                } else {
                  return const Text('Unhandled user role');
                }
              } else {
                return const Text('User role not available');
              }
            }
          }
        },
      );
    }
  }
}

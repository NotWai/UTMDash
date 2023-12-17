import 'package:flutter/material.dart';
import 'package:utm_dash/HomePage.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/services/f_database.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/screens/customer_wrapper.dart';
import 'package:utm_dash/viewHubPage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key});
  


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass?>(context);
    print(user);
    if (user == null) {
      return HomePage();
    } else {
      return FutureBuilder<String?>(
        future: DatabaseService(uid: user.uid).fetchedUserRoleFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the role, you can show a loading indicator
            return CircularProgressIndicator(); // Replace this with your loading widget
          } else {
            if (snapshot.hasError) {
              // Handle errors in fetching user role
              return Text('Error fetching user role');
            } else {
              String? userRole = snapshot.data;

              if (userRole != null) {
                if (userRole == 'normal') {
                  return const CustomerWrapper();
                } else if (userRole == 'Hub') {
                  return ViewHubPage();
                } else {
                  // Handle other cases or errors
                  return Text('Unhandled user role');
                }
              } else {
                // Handle case where user role couldn't be fetched
                return Text('User role not available');
              }
            }
          }
        },
      );
    }
  }
}


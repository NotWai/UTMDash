import 'package:flutter/material.dart';
import 'package:utm_dash/CustLoginPage.dart';
import 'package:utm_dash/HomePage.dart';
import 'package:utm_dash/request_box.dart';
import 'package:utm_dash/request_details.dart';
import 'package:utm_dash/Signup.dart';

void main() {
  runApp(const MyApp());
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignUp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

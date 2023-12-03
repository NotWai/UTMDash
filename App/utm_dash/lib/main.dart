// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:utm_dash/HomePage.dart';
import 'package:utm_dash/IntroPage.dart';
import 'package:utm_dash/request_box.dart';
import 'package:utm_dash/request_details.dart';
import 'package:utm_dash/signup.dart';
import 'package:utm_dash/viewCustomerPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyA1dPSUPvWXJQiJldbYekcdljcLBfEIRQ4",
      appId: "1:274283878114:android:dc7123b4b882a9c78c70bb",
      messagingSenderId: "274283878114",
      projectId: "utmdash-a9abf",
    ),
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
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

import 'package:flutter/material.dart';
import 'package:utm_dash/login_page.dart';
import 'view_runner_page.dart';

void main() {
  runApp(const MyApp());
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
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

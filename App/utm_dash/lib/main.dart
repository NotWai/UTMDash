// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/screens/wrapper.dart';
import 'package:utm_dash/services/auth.dart';
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserClass?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:utm_dash/API/firebase_api.dart';
import 'package:utm_dash/models/user.dart';
import 'package:utm_dash/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:utm_dash/viewCustomerPage.dart';
import 'package:utm_dash/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA1dPSUPvWXJQiJldbYekcdljcLBfEIRQ4",
      appId: "1:274283878114:android:dc7123b4b882a9c78c70bb",
      messagingSenderId: "274283878114",
      projectId: "utmdash-a9abf",
    ),
  );
  await FirebaseAPI().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserClass?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        routes: {
          '/notification_screen': (context) => CustomerPage(),
        },
        home: const SplashScreen(),
      ),
    );
  }
}

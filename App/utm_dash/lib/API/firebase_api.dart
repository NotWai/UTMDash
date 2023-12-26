// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:utm_dash/main.dart';

class FirebaseAPI{
  final _firebaseMessage = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessage.requestPermission();
    final fcmToken = await _firebaseMessage.getToken();
    print('Token: $fcmToken');
    initPushNotification();
  }

  void handleMessage(RemoteMessage? message){
    if (message == null) return;
    navigatorKey.currentState?.pushNamed('/notification_screen',arguments: message);
  }

  Future initPushNotification() async {
    _firebaseMessage.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
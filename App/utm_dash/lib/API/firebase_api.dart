// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:utm_dash/main.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('body ${message.messageId}');
}

class FirebaseAPI {
  final _firebaseMessage = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessage.requestPermission();
    final fcmToken = await _firebaseMessage.getToken();
    print('Token: $fcmToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed('/home', arguments: message);
  }

  Future initPushNotification() async {
    _firebaseMessage.getInitialMessage().then((message) {
      print('Initial Message: $message');
      handleMessage(message);
    });

    FirebaseMessaging.onMessage.listen((message) {
      print('Received Message: $message');
      handleMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  Future<void> sendMessage({
    required String fcmToken,
    required String title,
    required String body,
  }) async {
    try {
      await _firebaseMessage.sendMessage(
        to: fcmToken,
        data: {
          'title': title,
          'body': body,
        },
      );
      print('Message sent successfully.');
        } catch (e) {
      print('Error sending message: $e');
    }
  }
}

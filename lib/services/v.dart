import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class HandelNotificationService {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;

  static void initial() async {
    await getRequest();
    await getToken();
    handelForegroundNotification();
    handelBackgroundNotification();
  }

  static void handelForegroundNotification() {
    FirebaseMessaging.onMessage.listen(handelForeground);
  }

  static void handelBackgroundNotification() {
    FirebaseMessaging.onBackgroundMessage(handelBackground);
  }

  static Future<void> getToken() async {
    final String? token = await messaging.getToken();
    if (token != null) {
      log(token);
    }
  }

  static Future<void> getRequest() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static void handelForeground(RemoteMessage message) {
    log("${message.notification?.title}");
    log("${message.notification?.body}");
  }

  static Future<void> handelBackground(RemoteMessage message) async {
    log("${message.notification?.title}");
    log("${message.notification?.body}");
  }
}

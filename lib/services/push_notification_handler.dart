import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationHandler {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future<void> init() async {
    await getPermission();
    await getToken();
    handelForegroundNotification();
    handleBackgroundNotification();
  }

  static Future<void> getToken() async {
    final String? token = await messaging.getToken();
    if (token != null) {
      log('FCM Token: $token');
    }
  }

  static Future<void> getPermission() async {
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

  static void handelForegroundNotification() async {
    FirebaseMessaging.onMessage.listen(onForegroundMessage);
  }

  static void handleBackgroundNotification() async {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  }

  static void onForegroundMessage(RemoteMessage message) {
    //handle background notification using local notification
  }

  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    log('${message.notification?.title}}');
    log('${message.notification?.body}}');
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final String? token = await messaging.getToken();
    handelForegroundNotification();
    handelForegroundNotification();
  }

  static void handelForegroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          '======================================handelForegroundNotification onMessage======================================');

      print(message.notification?.title);
      print(message.notification?.body);
      print(message.from);
      setupLocalNotification(message);
      if (message.data != null) {
        print(message.data);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          '======================================handelForegroundNotification onMessageOpenedApp======================================');

      print(message.notification?.title);
      print(message.notification?.body);
      print(message.from);
      if (message.data != null) {
        print(message.data);
      }
    });
  }

  static void handelBackgroundNotification() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  }

  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    print(
        '======================================onBackgroundMessage======================================');

    print(message.notification?.title);
    print(message.notification?.body);
    print(message.from);
    setupLocalNotification(message);

    if (message.data != null) {
      print(message.data);
    }
  }

  static void setupLocalNotification(RemoteMessage remoteMessage) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("app_icon");
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
   
    NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
          "notification",
          "name",
          enableLights: true,
          enableVibration: true,
          autoCancel: true,
          priority: Priority.high,
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true));
    flutterLocalNotificationsPlugin.show(
        remoteMessage.hashCode,
        remoteMessage.notification?.title,
        remoteMessage.notification?.body,
        notificationDetails);
  }
}

// class Page2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Page 2")),
//       body: const Center(
//         child: Text("You navigated to Page 2!"),
//       ),
//     );
//   }
// }

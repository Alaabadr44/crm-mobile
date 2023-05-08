import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'local_notification.dart';

class NotificationsManager {
  NotificationsManager._();

  factory NotificationsManager() => _instance;

  static final NotificationsManager _instance = NotificationsManager._();

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  bool showNotification = true;

  getNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('getMessage::: $message');
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        debugPrint('notificationMessage::::${message.notification!.title}');
        debugPrint('notificationMessage::::${message.notification!.body}');
        debugPrint('notificationMessageData::::${message.data}');
      }
    });
    firebaseMessaging.requestPermission(
        sound: true, badge: true, alert: true, provisional: true);
  }

  Future<String?> getNotificationToken() {
    return firebaseMessaging.getToken().then((String? token) {
      debugPrint('token - fcm token :: //$token//');
      return token;
    });
  }

  static void showNotificationSnackBar({
    required String title,
    required String message,
    required String payload,
    required void Function(NotificationResponse) onReceive,
  }) async {
    /*Get.snackbar(title, message,
        icon: icon, onTap: onTap, duration: const Duration(seconds: 3));*/
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    bool? showNotification = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    debugPrint('show notification:: $showNotification');

    LocalNotification.initialize(flutterLocalNotificationsPlugin, onReceive);
    LocalNotification.showBigTextNotification(
        title: title,
        body: message,
        fln: flutterLocalNotificationsPlugin,
        payload: payload);
  }
}

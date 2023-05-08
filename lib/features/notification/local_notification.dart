import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      void Function(NotificationResponse) onReceive) async {
    var initializationsSettings = const InitializationSettings(
        android: AndroidInitializationSettings('mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings());
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveBackgroundNotificationResponse: onReceive,
        onDidReceiveNotificationResponse: onReceive);
  }

  static Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      title,
      'com.abg.sell_in',
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );

    var not = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails());
    await fln.show(id, title, body, not, payload: payload);
  }
}

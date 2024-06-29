import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationFunctions {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {
    log(notificationResponse.payload.toString());
  }

  static Future<void> initializeNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static void scheduleNotification(int id, DateTime scheduleTime) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "id",
      "channel",
      importance: Importance.max,
      priority: Priority.max,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      "Time is about to end",
      "Your task have 10 minutes left before the deadline",
      tz.TZDateTime.from(scheduleTime, tz.local),
      notificationDetails,
      payload: "Notification-payload",
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static void deleteNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static void deleteAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

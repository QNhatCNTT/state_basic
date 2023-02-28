import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/subjects.dart'; // for BehaviorSubject
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:state_basic/pages/apptodo.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const AndroidInitializationSettings android =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings iOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
        ) async {});
    final InitializationSettings initializationSettings =
        InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationRespons) async {
          final String? payload = notificationRespons.payload;
            onNotifications.add(payload);
      }
    );
  }

  static Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  static Future showScheduledNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
    required DateTime schduledDate,
  }) async {
    await _configureLocalTimeZone();
    return _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(schduledDate, tz.local),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
}

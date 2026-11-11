import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    final timeZoneInfo = await FlutterTimezone.getLocalTimezone();
    final String timeZoneName = timeZoneInfo.identifier;
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        // Handle notification tap
      },
    );
  }

  Future<void> requestPermissions() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
        
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
  }

  Future<void> scheduleDailyReminder(TimeOfDay time, String repeatMode) async {
    // First cancel any existing reminders
    await cancelAllReminders();

    final int hour = time.hour;
    final int minute = time.minute;

    // We'll use a specific ID for the daily reminder
    const int reminderId = 100;

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'daily_reminder_channel',
      'Daily Reminders',
      channelDescription: 'Channel for daily app reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosNotificationDetails,
    );

    if (repeatMode == 'Daily') {
      await _notificationsPlugin.zonedSchedule(
        reminderId,
        'Time for your EQi30 check-in!',
        'Take a few minutes for yourself today.',
        _nextInstanceOfTime(hour, minute),
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } else if (repeatMode == 'Weekdays') {
      // Schedule for Monday to Friday
      for (int i = 1; i <= 5; i++) {
        await _notificationsPlugin.zonedSchedule(
          reminderId + i,
          'Time for your EQi30 check-in!',
          'Take a few minutes for yourself today.',
          _nextInstanceOfWeekdayAndTime(i, hour, minute),
          platformChannelSpecifics,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
      }
    } else if (repeatMode == 'Weekends') {
      // Schedule for Saturday (6) and Sunday (7)
      for (int i = 6; i <= 7; i++) {
        await _notificationsPlugin.zonedSchedule(
          reminderId + i,
          'Time for your EQi30 check-in!',
          'Take a few minutes for yourself today.',
          _nextInstanceOfWeekdayAndTime(i, hour, minute),
          platformChannelSpecifics,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
      }
    }
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfWeekdayAndTime(
      int weekday, int hour, int minute) {
    tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minute);
    while (scheduledDate.weekday != weekday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> cancelAllReminders() async {
    await _notificationsPlugin.cancelAll();
  }

  Future<bool> checkPermissions() async {
    final androidImpl = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl != null) {
      return await androidImpl.areNotificationsEnabled() ?? false;
    }
    final iosImpl = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    if (iosImpl != null) {
      final res = await iosImpl.checkPermissions();
      return res?.isEnabled ?? false;
    }
    return false;
  }

  Future<void> scheduleInactivityNudge(int nudgeDays) async {
    const int nudgeId = 200;
    await _notificationsPlugin.cancel(nudgeId);
    if (nudgeDays <= 0) return;

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      10,
      0,
    ).add(Duration(days: nudgeDays));

    const platformDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'inactivity_nudge_channel',
        'Gentle Practice Nudges',
        channelDescription: 'Reminders when you have been away for a few days',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _notificationsPlugin.zonedSchedule(
      nudgeId,
      'Your 5-minute EQ practice misses you!',
      'Consistency beats intensity. Come back for a quick microskill today.',
      scheduledDate,
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> scheduleEndOfDayReflectionReminder({
    TimeOfDay time = const TimeOfDay(hour: 20, minute: 30),
  }) async {
    const int eodId = 201;
    await _notificationsPlugin.cancel(eodId);

    const platformDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'eod_reflection_channel',
        'End of Day Reflections',
        channelDescription: 'Evening reminder to finish your daily EQ reflection',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _notificationsPlugin.zonedSchedule(
      eodId,
      'How did today’s EQ practice go?',
      'Take 60 seconds to complete your evening reflection.',
      _nextInstanceOfTime(time.hour, time.minute),
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelEndOfDayReflectionReminder() async {
    await _notificationsPlugin.cancel(201);
  }
}

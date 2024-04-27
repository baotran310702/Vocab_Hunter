// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:english_learner/models/time_notification.dart';
import 'package:english_learner/models/word_notification.dart';
import 'package:english_learner/services/time_notification_local.dart';
import 'package:english_learner/services/word_notification_local.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

// on tap on any notification
  static void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

// initialize the local notifications
  Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {
        return;
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  // show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel id 1',
      'Channel Name 1',
      channelDescription: 'Channel Description 1',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  // to show periodic notification at regular interval
  static Future showPeriodicNotifications({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel 2', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.periodicallyShow(
        1, title, body, RepeatInterval.everyMinute, notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payload);
  }

  //request permission notifications
  static Future requestPermission() async {
    var status = await Permission.notification.status;
    if (status.isDenied) {
      await Permission.notification.request();
    }
  }

  //showDailySchduledNotification
  static Future<void> showDailySchduledNotification({
    required int hour,
    required int minutes,
    required int id,
    required WordNotification word,
  }) async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
      id.toString(),
      'daily schduled notification',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails details = NotificationDetails(
      android: android,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id, // Unique ID based on index"
      "Daily vocab: ${word.words.$1.word ?? ''}",
      "${word.words.$1.word ?? ''} - ${word.words.$2.word ?? ''}",
      _convertTime(hour, minutes),
      details,
      // ignore: deprecated_member_use
      androidAllowWhileIdle: true,
      payload: 'zonedSchedule',

      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Set right date and time for notifications
  static tz.TZDateTime _convertTime(int hour, int minutes) {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Bangkok'));
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  static Future<void> showMultiNotificationsSchedule() async {
    ListTimeNotification listTimeNotification =
        await TimeNotificationLocal().getListTimeNotification();

    List<TimeNotification> listTimeNotificationList =
        listTimeNotification.listTimeNotification;
    List<TimeNotification> listActiveNotification = listTimeNotificationList
        .where((element) => element.isActive == true)
        .toList();

    final listTimeSchedule = listActiveNotification
        .map((e) => _convertTime(e.time.hour, e.time.minute))
        .toList();

    final listWordNotification = await WordNotificationServices()
        .getNWordNotificationLocal(listTimeSchedule.length);

    int lenListWord = listWordNotification.listWordNotification.length;

    if (lenListWord == 0) return;

    for (int i = 0; i < listTimeSchedule.length; i++) {
      WordNotification currentWord = i > lenListWord
          ? listWordNotification.listWordNotification[i - lenListWord]
          : listWordNotification.listWordNotification[i];
      showDailySchduledNotification(
        hour: listTimeNotificationList[i].time.hour,
        minutes: listTimeNotificationList[i].time.minute,
        id: listTimeNotificationList[i].time.hour *
            listTimeNotificationList[i].time.minute,
        word: currentWord,
      );
    }
  }

  //showRepeatedNotification
  static void showRepeatedNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'id 2',
      'repeated notification',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails details = const NotificationDetails(
      android: android,
    );
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      'Reapated Notification',
      'body',
      RepeatInterval.everyMinute,
      details,
      payload: "Payload Data",
    );
  }

  // close a specific channel notification
  static Future cancel(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // close all the notifications available
  static Future cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}

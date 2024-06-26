// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:english_learner/models/time_notification.dart';
import 'package:english_learner/models/word_notification.dart';
import 'package:english_learner/services/time_notification_local.dart';
import 'package:english_learner/services/word_notification_local.dart';
import 'package:english_learner/utils/extension.dart';
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
      "Daily vocab: ${word.englishWords.word?.toUpperCase() ?? ''}",
      "${word.englishWords.word?.capitalize() ?? ''} - ${word.vietnameseWords.word?.capitalize() ?? ''}",
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
    await Future.wait([
      WordNotificationServices().init(),
      TimeNotificationLocal().init(),
    ]);

    ListTimeNotification listTimeNotification =
        await TimeNotificationLocal().getListTimeNotification();

    ListWordNotification listWordNotification =
        await WordNotificationServices().getNWordNotificationLocal(20);

    List<TimeNotification> listTimeNotificationList =
        listTimeNotification.listTimeNotification;
    List<TimeNotification> listActiveNotification = listTimeNotificationList
        .where((element) => element.isActive == true)
        .toList();

    List<TimeNotification> filteredListTime = listActiveNotification
        .where((element) =>
            element.isActive == true &&            
                element.time.hour > DateTime.now().hour ||
            (element.time.minute > DateTime.now().minute &&
                element.time.hour == DateTime.now().hour))
        .toList();

    final listTimeSchedule = filteredListTime
        .map((e) => _convertTime(e.time.hour, e.time.minute))
        .toList();

    int lenListWord = listWordNotification.listWordNotification.length;

    if (lenListWord == 0) return;

    for (int i = 0; i < 20; i++) {
      WordNotification currentWord = i > lenListWord - 1
          ? listWordNotification.listWordNotification[i - lenListWord - 1]
          : listWordNotification.listWordNotification[i];
      await showDailySchduledNotification(
        hour: listTimeSchedule[i].hour,
        minutes: listTimeSchedule[i].minute,
        id: listTimeSchedule[i].hour * listTimeSchedule[i].minute,
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

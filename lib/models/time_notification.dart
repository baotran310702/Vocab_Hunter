import 'package:english_learner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'time_notification.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveTimeNotificationId)
class TimeNotification {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final TimeOfDay time;
  @HiveField(2)
  final bool isActive;

  TimeNotification({
    required this.title,
    required this.time,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'time': {
        'hour': time.hour,
        'minute': time.minute,
      },
      'isActive': isActive,
    };
  }

  factory TimeNotification.fromJson(Map<String, dynamic> json) {
    return TimeNotification(
      title: json['title'],
      time: TimeOfDay(
        hour: json['time']['hour'],
        minute: json['time']['minute'],
      ),
      isActive: json['isActive'],
    );
  }

  factory TimeNotification.initial() {
    return TimeNotification(
      title: "Default init",
      time: TimeOfDay.now(),
      isActive: false,
    );
  }

  //copy with
  TimeNotification copyWith({
    String? title,
    TimeOfDay? time,
    bool? isActive,
  }) {
    return TimeNotification(
      title: title ?? this.title,
      time: time ?? this.time,
      isActive: isActive ?? this.isActive,
    );
  }
}

@HiveType(typeId: KeyHiveLocal.hiveListTimeNotificationId)
class ListTimeNotification {
  @HiveField(0)
  final List<TimeNotification> listTimeNotification;

  factory ListTimeNotification.initial() {
    return ListTimeNotification(listTimeNotification: []);
  }

  ListTimeNotification({required this.listTimeNotification});
}

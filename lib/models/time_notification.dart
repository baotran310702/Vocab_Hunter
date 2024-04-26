import 'package:english_learner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'time_notification.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveTimeNotificationId)
class TimeNotification {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final TimeOfDay time;
  @HiveField(2)
  final bool isActive;

  TimeNotification({
    required this.id,
    required this.time,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': {
        'hour': time.hour,
        'minute': time.minute,
      },
      'isActive': isActive,
    };
  }

  factory TimeNotification.fromJson(Map<String, dynamic> json) {
    return TimeNotification(
      id: json['id'],
      time: TimeOfDay(
        hour: json['time']['hour'],
        minute: json['time']['minute'],
      ),
      isActive: json['isActive'],
    );
  }

  factory TimeNotification.initial() {
    return TimeNotification(
      id: -1,
      time: TimeOfDay.now(),
      isActive: false,
    );
  }

  //copy with
  TimeNotification copyWith({
    int? id,
    TimeOfDay? time,
    bool? isActive,
  }) {
    return TimeNotification(
      id: id ?? this.id,
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

  factory ListTimeNotification.empty() {
    return ListTimeNotification(listTimeNotification: []);
  }

  ListTimeNotification({required this.listTimeNotification});
}

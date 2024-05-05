import 'package:english_learner/utils/converter.dart';

class NotificationApp {
  final String title;
  final String body;
  final DateTime time;

  NotificationApp(
      {required this.title, required this.body, required this.time});

  factory NotificationApp.fromMap(dynamic map) {
    return NotificationApp(
      title: CustomConverter.convertToString(map['title'] ?? ""),
      body: CustomConverter.convertToString(map['body'] ?? ""),
      time: CustomConverter.convertToDateTime(map['time'] ?? DateTime.now()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'time': time,
    };
  }

  @override
  String toString() =>
      'NotificationApp(title: $title, body: $body, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationApp &&
        other.title == title &&
        other.body == body &&
        other.time == time;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode ^ time.hashCode;

  NotificationApp copyWith({
    String? title,
    String? body,
    DateTime? time,
  }) {
    return NotificationApp(
      title: title ?? this.title,
      body: body ?? this.body,
      time: time ?? this.time,
    );
  }
}

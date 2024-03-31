import 'package:english_learner/utils/enum.dart';

class Achievement {
  final String title;
  final String description;
  final AchievementType type;
  final int amount;
  final int total;

  Achievement({
    required this.title,
    required this.description,
    required this.type,
    required this.amount,
    required this.total,
  });

  factory Achievement.defaultInit() {
    return Achievement(
      title: "title",
      description: "description",
      type: AchievementType.sleepyBoi,
      amount: 100,
      total: 150,
    );
  }

  factory Achievement.fromJson(dynamic json) {
    return Achievement(
      title: json['title'].toString(),
      description: json['description'].toString(),
      type: json['type'],
      amount: json['amount'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'amount': amount,
      'total': total,
    };
  }

  Achievement copyWith({
    String? title,
    String? description,
    AchievementType? type,
    int? amount,
    int? total,
  }) {
    return Achievement(
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      total: total ?? this.total,
    );
  }
}

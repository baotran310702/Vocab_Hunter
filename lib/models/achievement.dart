import 'package:english_learner/utils/constants.dart';
import 'package:english_learner/utils/enum.dart';
import 'package:hive/hive.dart';

part 'achievement.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveAchievementId)
class Achievement {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final AchievementType type;
  @HiveField(3)
  final int amount;
  @HiveField(4)
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

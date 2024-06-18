import 'package:english_learner/utils/constants.dart';
import 'package:english_learner/utils/converter.dart';
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
  @HiveField(5)
  final CustomAchievement customAchievement;

  Achievement({
    required this.title,
    required this.description,
    required this.type,
    required this.amount,
    required this.total,
    required this.customAchievement,
  });

  factory Achievement.defaultInit() {
    return Achievement(
      title: "title",
      description: "description",
      type: AchievementType.capySleeping,
      amount: 100,
      total: 150,
      customAchievement: CustomAchievement.trainRoom,
    );
  }

  factory Achievement.fromJson(dynamic json) {
    return Achievement(
      title: json['title'].toString(),
      description: json['description'].toString(),
      type: json['type'] != null
          ? CustomConverter.convertToAchievementType(json['type'])
          : AchievementType.capySleeping,
      amount: json['amount'],
      total: json['total'],
      customAchievement: json['customAchievement'] != null
          ? CustomConverter.convertToCustomAchievement(
              json['customAchievement'])
          : CustomAchievement.trainRoom,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'type': CustomConverter.convertAchievementTypeToIndex(type),
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

  static List<Achievement> defaultListAchievement = [
    Achievement(
      title: "Capy Vocab",
      description:
          "You have learned 150 words in practise room to receive this achievement.",
      type: AchievementType.capySleeping,
      amount: 0,
      total: 150,
    ),
    Achievement(
      title: "Capy Topics",
      description: "You have learned 5 topics to receive this achievement.",
      type: AchievementType.capyWritting,
      amount: 0,
      total: 5,
    ),
    Achievement(
      title: "Capy Hardwork",
      description:
          "Search 100 words in dictionary to receive this achievement.",
      type: AchievementType.capyGraduate1,
      amount: 0,
      total: 100,
    ),
    Achievement(
      title: "Capy Pratise",
      description:
          "You have to completed 5 times in pratises room with no failures to receive this achievement.",
      type: AchievementType.capyGraduate,
      amount: 0,
      total: 5,
    ),
  ];
}

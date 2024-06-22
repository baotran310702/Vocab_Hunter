import 'package:english_learner/utils/constants.dart';
import 'package:english_learner/utils/converter.dart';
import 'package:english_learner/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'achievement.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveAchievementId)
class Achievement extends ChangeNotifier {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final AchievementType type;
  @HiveField(3)
  int amount;
  @HiveField(4)
  final int total;
  @HiveField(5)
  final CustomAchievement customAchievement;
  @HiveField(6)
  final String id;
  @HiveField(7)
  bool isAlert;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.amount,
    required this.total,
    required this.customAchievement,
    required this.isAlert,
  });

  void updateAmount() {
    amount++;
    notifyListeners();
  }

  factory Achievement.defaultInit() {
    return Achievement(
      id: "id",
      title: "title",
      description: "description",
      type: AchievementType.capyDoctor,
      amount: 100,
      total: 150,
      customAchievement: CustomAchievement.trainRoom,
      isAlert: false,
    );
  }

  factory Achievement.fromJson(dynamic json) {
    return Achievement(
      id: json['id'] ?? "",
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
      isAlert: json['isAlert'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': CustomConverter.convertAchievementTypeToIndex(type),
      'amount': amount,
      'total': total,
      'customAchievement':
          CustomConverter.convertCustomAchievemntToString(customAchievement),
      'isAlert': isAlert,
    };
  }

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    AchievementType? type,
    int? amount,
    int? total,
    CustomAchievement? customAchievement,
    bool? isAlert,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      total: total ?? this.total,
      customAchievement: customAchievement ?? this.customAchievement,
      isAlert: isAlert ?? this.isAlert,
    );
  }

  static List<Achievement> defaultListAchievement = [
    Achievement(
      id: "0",
      title: "Capy Vocab",
      description:
          "You have to learn 10 words in practise room to receive this achievement.",
      type: AchievementType.capySleeping,
      amount: 0,
      total: 10,
      customAchievement: CustomAchievement.vocab,
      isAlert: false,
    ),
    Achievement(
      id: "1",
      title: "Capy Topics",
      description: "You have learned 5 topics to receive this achievement.",
      type: AchievementType.capyWritting,
      amount: 0,
      total: 1,
      customAchievement: CustomAchievement.topic,
      isAlert: false,
    ),
    Achievement(
      id: "2",
      title: "Capy Hardwork",
      description: "Search 5 words in dictionary to receive this achievement.",
      type: AchievementType.capyGraduate1,
      amount: 0,
      total: 5,
      customAchievement: CustomAchievement.vocab,
      isAlert: false,
    ),
    Achievement(
      id: "3",
      title: "Capy Pratise",
      description:
          "You have to completed 5 times in pratises room with no failures to receive this achievement.",
      type: AchievementType.capyGraduate,
      amount: 0,
      total: 1,
      customAchievement: CustomAchievement.trainRoom,
      isAlert: false,
    ),
  ];
}

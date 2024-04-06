import 'package:english_learner/models/achievement.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveUserId)
class UserModel {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String userName;
  @HiveField(2)
  final int rank;
  @HiveField(3)
  final List<Achievement> achievements;
  @HiveField(4)
  final List<String> learnedWords;
  @HiveField(5)
  final List<String> learningWords;

  const UserModel({
    required this.uid,
    required this.userName,
    required this.rank,
    required this.learnedWords,
    required this.achievements,
    required this.learningWords,
  });

  factory UserModel.initWithId(String uid, String userName) {
    return UserModel(
      uid: uid,
      userName: userName,
      rank: 0,
      learnedWords: [],
      learningWords: [],
      achievements: [],
    );
  }

  factory UserModel.initTest() {
    return UserModel(
      uid: "aioximaaaaaa",
      userName: "Bao dep traiii ",
      rank: 0,
      learnedWords: [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
      ],
      learningWords: [
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
      ],
      achievements: [
        Achievement.defaultInit(),
        Achievement.defaultInit(),
        Achievement.defaultInit(),
        Achievement.defaultInit(),
        Achievement.defaultInit(),
      ],
    );
  }

  factory UserModel.empty() {
    return const UserModel(
      uid: "",
      userName: "",
      rank: 0,
      learnedWords: [],
      learningWords: [],
      achievements: [],
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    final String userName = data['userName'] ?? "";
    final int rank = data['rank'] ?? -1;
    final List<dynamic> learnedWords = data['learnedWords'] ?? [];
    final List<dynamic> learningWords = data['learningWords'] ?? [];
    final List<Achievement> listAchievement = [];
    for (var item in data['achievements']) {
      listAchievement.add(Achievement.fromJson(item));
    }

    return UserModel(
      uid: documentId,
      userName: userName,
      rank: rank,
      achievements: listAchievement,
      learnedWords: learnedWords.map((e) => e.toString()).toList(),
      learningWords: learningWords.map((e) => e.toString()).toList(),
    );
  }

  UserModel copyWith({
    String? uid,
    String? userName,
    int? rank,
    List<String>? learnedWords,
    List<String>? learningWords,
    List<Achievement>? achievements,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      rank: rank ?? this.rank,
      learnedWords: learnedWords ?? this.learnedWords,
      learningWords: learningWords ?? this.learningWords,
      achievements: achievements ?? this.achievements,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'rank': rank,
      'learnedWords': learnedWords,
      'learningWords': learningWords,
      'achievements': achievements.map((e) => e.toJson()).toList(),
    };
  }
}

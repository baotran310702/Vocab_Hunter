import 'package:english_learner/models/achievement.dart';

class UserModel {
  final String uid;
  final String userName;
  final int rank;
  final List<Achievement> achievements;
  final List<String> learnedWords;
  final List<String> learningWors;

  const UserModel({
    required this.uid,
    required this.userName,
    required this.rank,
    required this.learnedWords,
    required this.achievements,
    required this.learningWors,
  });

  factory UserModel.initWithId(String uid, String userName) {
    return UserModel(
      uid: uid,
      userName: userName,
      rank: 0,
      learnedWords: [],
      learningWors: [],
      achievements: [],
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    final String userName = data['userName'];
    final int rank = data['rank'];
    final List<dynamic> learnedWords = data['learnedWords'];
    final List<dynamic> learningWors = data['learningWors'];
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
      learningWors: learningWors.map((e) => e.toString()).toList(),
    );
  }

  UserModel copyWith({
    String? uid,
    String? userName,
    int? rank,
    List<String>? learnedWords,
    List<String>? learningWors,
    List<Achievement>? achievements,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      rank: rank ?? this.rank,
      learnedWords: learnedWords ?? this.learnedWords,
      learningWors: learningWors ?? this.learningWors,
      achievements: achievements ?? this.achievements,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'rank': rank,
      'learnedWords': learnedWords,
      'learningWors': learningWors,
      'achievements': achievements.map((e) => e.toJson()).toList(),
    };
  }
}

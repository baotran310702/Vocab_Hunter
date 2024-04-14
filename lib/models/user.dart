import 'package:english_learner/models/achievement.dart';
import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveUserId)
class UserModel extends Equatable {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String userName;
  @HiveField(2)
  final int rank;
  @HiveField(3)
  final List<Achievement> achievements;
  @HiveField(4)
  final List<UserVocab> learnedWords;
  @HiveField(5)
  final List<UserVocab> learningWords;

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
      learnedWords: const [],
      learningWords: const [],
      achievements: const [],
    );
  }

  factory UserModel.defaultInit() {
    return UserModel(
      uid: "aioximaaaaaa",
      userName: "Bao dep traiii ",
      rank: 0,
      learnedWords: const [
        UserVocab(
          listId: "0",
          listName: "List 1",
          listVocabulary: ["hello", "world", "goodbye"],
        ),
        UserVocab(
          listId: "1",
          listName: "List 2",
          listVocabulary: ["hello", "world", "goodbye"],
        ),
        UserVocab(
          listId: "2",
          listName: "List 3",
          listVocabulary: ["hello", "world", "goodbye"],
        ),
      ],
      learningWords: const [
        UserVocab(
          listId: "0",
          listName: "List 1",
          listVocabulary: ["hello", "world", "goodbye"],
        ),
        UserVocab(
          listId: "1",
          listName: "List 2",
          listVocabulary: ["hello", "world", "goodbye"],
        ),
        UserVocab(
          listId: "2",
          listName: "List 3",
          listVocabulary: ["hello", "world", "goodbye"],
        ),
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
    final List<UserVocab> learnedWords = [];
    for (var item in data['learnedWords']) {
      learnedWords.add(UserVocab.fromJson(item));
    }

    final List<UserVocab> learningWords = [];
    for (var item in data['learningWords']) {
      learningWords.add(UserVocab.fromJson(item));
    }

    final List<Achievement> listAchievement = [];
    for (var item in data['achievements']) {
      listAchievement.add(Achievement.fromJson(item));
    }

    return UserModel(
      uid: documentId,
      userName: userName,
      rank: rank,
      achievements: listAchievement,
      learnedWords: learnedWords,
      learningWords: learningWords,
    );
  }

  UserModel copyWith({
    String? uid,
    String? userName,
    int? rank,
    List<UserVocab>? learnedWords,
    List<UserVocab>? learningWords,
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
      'learnedWords': learnedWords.map((e) => e.toJson()).toList(),
      'learningWords': learningWords.map((e) => e.toJson()).toList(),
      'achievements': achievements.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props =>
      [uid, userName, rank, learnedWords, learningWords, achievements];
}

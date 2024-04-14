import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import '../utils/constants.dart';

part 'user_vocab.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveUserVocab)
class UserVocab extends Equatable {
  @HiveField(0)
  final String listId;
  @HiveField(1)
  final String listName;
  @HiveField(2)
  final List<VocabularyRemote> listVocabulary;

  const UserVocab({
    required this.listId,
    required this.listName,
    required this.listVocabulary,
  });

  factory UserVocab.fromJson(Map<String, dynamic> json) {
    List<VocabularyRemote> listVocab =
        json['listVocabulary'] is List && json['listVocabulary'].isEmpty
            ? <VocabularyRemote>[]
            : json['listVocabulary'].map((e) => e.fromJson()).toList();
    return UserVocab(
      listId: json['listId'] ?? "",
      listName: json['listName'] ?? "",
      listVocabulary: listVocab,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listId': listId,
      'listName': listName,
      'listVocabulary': listVocabulary.map((e) => e.toJson()).toList(),
    };
  }

  UserVocab copyWith({
    String? listId,
    String? listName,
    List<VocabularyRemote>? listVocabulary,
  }) {
    return UserVocab(
      listId: listId ?? this.listId,
      listName: listName ?? this.listName,
      listVocabulary: listVocabulary ?? this.listVocabulary,
    );
  }

  @override
  List<Object?> get props => [listId, listName, listVocabulary];
}

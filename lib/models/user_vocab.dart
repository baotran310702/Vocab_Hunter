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
  final Map<String, List<VocabularyRemote>> listVocabulary;

  const UserVocab({
    required this.listId,
    required this.listName,
    required this.listVocabulary,
  });

  factory UserVocab.empty() {
    return const UserVocab(
      listId: "",
      listName: "",
      listVocabulary: {},
    );
  }

  factory UserVocab.fromJson(Map<String, dynamic> json) {
    List<dynamic> listVocab = json['listVocabulary']['english'] is List &&
            json['listVocabulary']['english'].isEmpty
        ? <VocabularyRemote>[]
        : json['listVocabulary']
            .map((e) => VocabularyRemote.fromJson(e))
            .toList();
    List<dynamic> listTranslatedVocabulary =
        json['listVocabulary']['translated'] is List &&
                json['listVocabulary']['translated'].isEmpty
            ? <VocabularyRemote>[]
            : json['listVocabulary']['translated']
                .map((e) => VocabularyRemote.fromJson(e))
                .toList();
    return UserVocab(
      listId: json['listId'] ?? "",
      listName: json['listName'] ?? "",
      listVocabulary: {
        'english': listVocab.map((e) => e as VocabularyRemote).toList(),
        'translated':
            listTranslatedVocabulary.map((e) => e as VocabularyRemote).toList(),
      },
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listId': listId,
      'listName': listName,
      'listVocabulary': listVocabulary,
    };
  }

  UserVocab copyWith({
    String? listId,
    String? listName,
    Map<String, List<VocabularyRemote>>? listVocabulary,
  }) {
    return UserVocab(
      listId: listId ?? this.listId,
      listName: listName ?? this.listName,
      listVocabulary: listVocabulary ?? this.listVocabulary,
    );
  }

  @override
  List<Object?> get props => [
        listId,
        listName,
        listVocabulary,
      ];
}

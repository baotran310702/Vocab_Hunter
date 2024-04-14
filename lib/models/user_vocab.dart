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
  final List<String> listVocabulary;

  const UserVocab({
    required this.listId,
    required this.listName,
    required this.listVocabulary,
  });

  factory UserVocab.fromJson(Map<String, dynamic> json) {
    List<String> listVocab =
        json['listVocabulary'] is List && json['listVocabulary'].isEmpty
            ? <String>[]
            : json['listVocabulary'].map((e) => e.toString()).toList();
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
      'listVocabulary': listVocabulary,
    };
  }

  UserVocab copyWith({
    String? listId,
    String? listName,
    List<String>? listVocabulary,
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

import 'package:hive/hive.dart';
import '../utils/constants.dart';

part 'user_vocab.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveUserVocab)
class UserVocab {
  @HiveField(0)
  final String listId;
  @HiveField(1)
  final String listName;
  @HiveField(2)
  final List<String> listVocabulary;

  UserVocab({
    required this.listId,
    required this.listName,
    required this.listVocabulary,
  });

  factory UserVocab.fromJson(Map<String, dynamic> json) {
    return UserVocab(
      listId: json['listId'] ?? "",
      listName: json['listName'] ?? "",
      listVocabulary: json['listVocabulary'] ?? [],
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
}

import 'package:hive/hive.dart';
import '../utils/constants.dart';

part 'user_vocab.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveUserVocab)
class UserVocab {
  @HiveField(0)
  final String listName;
  @HiveField(1)
  final List<String> listVocabulary;

  UserVocab({required this.listName, required this.listVocabulary});

  factory UserVocab.fromJson(Map<String, dynamic> json) {
    return UserVocab(
      listName: json['listName'] ?? "",
      listVocabulary: json['listVocabulary'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listName': listName,
      'listVocabulary': listVocabulary,
    };
  }

  UserVocab copyWith({
    String? listName,
    List<String>? listVocabulary,
  }) {
    return UserVocab(
      listName: listName ?? this.listName,
      listVocabulary: listVocabulary ?? this.listVocabulary,
    );
  }
}

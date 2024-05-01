import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';

part 'vocab_translated_local.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveVocabularyTranslated)
class VocabTranslatedLocalModel {
  @HiveField(0)
  final VocabularyRemote englishWords;
  @HiveField(1)
  final VocabularyRemote vietnameseWords;

  VocabTranslatedLocalModel({
    required this.englishWords,
    required this.vietnameseWords,
  });

  factory VocabTranslatedLocalModel.empty() {
    return VocabTranslatedLocalModel(
      englishWords: VocabularyRemote.empty(),
      vietnameseWords: VocabularyRemote.empty(),
    );
  }

  VocabTranslatedLocalModel copyWith({
    VocabularyRemote? englishWords,
    VocabularyRemote? vietnameseWords,
  }) {
    return VocabTranslatedLocalModel(
      englishWords: englishWords ?? this.englishWords,
      vietnameseWords: vietnameseWords ?? this.vietnameseWords,
    );
  }
}

@HiveType(typeId: KeyHiveLocal.hiveListVocabTranslated)
class ListVocabTranslated {
  @HiveField(0)
  final List<VocabTranslatedLocalModel> listVocabTranslated;

  ListVocabTranslated({required this.listVocabTranslated});

  factory ListVocabTranslated.empty() {
    return ListVocabTranslated(listVocabTranslated: []);
  }

  factory ListVocabTranslated.from(
      List<VocabTranslatedLocalModel> listVocabTranslated) {
    return ListVocabTranslated(
      listVocabTranslated: List.from(listVocabTranslated),
    );
  }

  ListVocabTranslated copyWith({
    List<VocabTranslatedLocalModel>? listVocabTranslated,
  }) {
    return ListVocabTranslated(
      listVocabTranslated: listVocabTranslated ?? this.listVocabTranslated,
    );
  }
}

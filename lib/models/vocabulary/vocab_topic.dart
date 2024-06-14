// ignore_for_file: must_be_immutable

import 'package:english_learner/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'vocab_topic.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveTopicVocabLocalNew)
class VocabTopic extends Equatable {
  @HiveField(0)
  String word;
  @HiveField(1)
  String pronounce;
  @HiveField(2)
  String type;
  @HiveField(3)
  String meaning;
  @HiveField(4)
  String exampleEnglish;
  @HiveField(5)
  String exampleVietnamese;
  @HiveField(6)
  String topic;

  VocabTopic({
    required this.word,
    required this.pronounce,
    required this.type,
    required this.meaning,
    required this.exampleEnglish,
    required this.exampleVietnamese,
    required this.topic,
  });

  // from map and using ?? to check null
  factory VocabTopic.fromMap(Map<String, dynamic> map) {
    return VocabTopic(
      word: map['word'] ?? '',
      pronounce: map['pronouce'] ?? '',
      type: map['type'] ?? '',
      meaning: map['meaning'] ?? '',
      exampleEnglish: map['exampleEnglish'] ?? '',
      exampleVietnamese: map['exampleVietnamese'] ?? '',
      topic: map['topic'] ?? '',
    );
  }

  //to map
  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'pronouce': pronounce,
      'type': type,
      'meaning': meaning,
      'exampleEnglish': exampleEnglish,
      'exampleVietnamese': exampleVietnamese,
      'topic': topic,
    };
  }

  //factory a copy with
  VocabTopic copyWith({
    String? word,
    String? pronounce,
    String? type,
    String? meaning,
    String? exampleEnglish,
    String? exampleVietnamese,
    String? topic,
  }) {
    return VocabTopic(
      word: word ?? this.word,
      pronounce: pronounce ?? this.pronounce,
      type: type ?? this.type,
      meaning: meaning ?? this.meaning,
      exampleEnglish: exampleEnglish ?? this.exampleEnglish,
      exampleVietnamese: exampleVietnamese ?? this.exampleVietnamese,
      topic: topic ?? this.topic,
    );
  }

  @override
  List<Object?> get props => [
        word,
        pronounce,
        type,
        meaning,
        exampleEnglish,
        exampleVietnamese,
        topic,
      ];
}

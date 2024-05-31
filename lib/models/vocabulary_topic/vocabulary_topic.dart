import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';

part 'vocabulary_topic.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveTopicVocabLocal)
class VocabularyByTopic {
  @HiveField(0)
  final String word;
  @HiveField(1)
  final String meaning;
  @HiveField(2)
  final String pronouce;
  @HiveField(3)
  final String topic;

  VocabularyByTopic({
    required this.word,
    required this.meaning,
    required this.pronouce,
    required this.topic,
  });

  factory VocabularyByTopic.fromJson(Map<String, dynamic> json) {
    return VocabularyByTopic(
      word: json['word'] ?? "",
      meaning: json['meaning'] ?? "",
      pronouce: json['pronouce'] ?? "",
      topic: json['topic'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'meaning': meaning,
      'pronouce': pronouce,
      'topic': topic,
    };
  }
}

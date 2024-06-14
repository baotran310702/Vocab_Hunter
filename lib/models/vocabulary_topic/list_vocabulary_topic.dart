import 'package:english_learner/models/vocabulary/vocab_topic.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';

part 'list_vocabulary_topic.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveListTopicVocabLocal)
class ListVocabularyTopic {
  @HiveField(0)
  final String topic;
  @HiveField(1)
  final List<VocabTopic> vocabularyByTopic;

  ListVocabularyTopic({
    required this.topic,
    required this.vocabularyByTopic,
  });

  //factory empty
  factory ListVocabularyTopic.empty() {
    return ListVocabularyTopic(topic: "", vocabularyByTopic: []);
  }

  factory ListVocabularyTopic.fromJson(Map<String, dynamic> json) {
    return ListVocabularyTopic(
      topic: json['topic'] ?? "",
      vocabularyByTopic: json['vocab'] != null
          ? json['vocab']
              .map<VocabTopic>((item) => VocabTopic.fromMap(item))
              .toList()
          : [],
    );
  }
}

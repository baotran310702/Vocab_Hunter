import 'package:english_learner/models/vocabulary_topic/vocabulary_topic.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';

part 'list_vocabulary_topic.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveListTopicVocabLocal)
class ListVocabularyTopic {
  @HiveField(0)
  final String topic;
  @HiveField(1)
  final List<VocabularyByTopic> vocabularyByTopic;

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
              .map<VocabularyByTopic>(
                  (item) => VocabularyByTopic.fromJson(item))
              .toList()
          : [],
    );
  }
}

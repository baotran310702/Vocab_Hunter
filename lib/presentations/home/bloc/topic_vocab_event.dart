part of 'topic_vocab_bloc.dart';

abstract class TopicVocabEvent {}

class GetVocabTopicEvent extends TopicVocabEvent {
  final SubTopic subTopic;
  GetVocabTopicEvent({required this.subTopic});
}

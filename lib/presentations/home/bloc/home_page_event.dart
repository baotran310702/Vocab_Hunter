part of 'home_page_bloc.dart';

abstract class HomePageEvent {}

class HomePageInitialEvent extends HomePageEvent {}

class CreateRecommendWords extends HomePageEvent {
  final String word;
  CreateRecommendWords({required this.word});
}

class InitTopicVocabulary extends HomePageEvent {}

class InitDetailTopicVocabulary extends HomePageEvent {}

class DownLoadDetailTopicVocab extends HomePageEvent {
  final String subTopicId;
  final String topicId;
  DownLoadDetailTopicVocab({
    required this.topicId,
    required this.subTopicId,
  });
}

class ChangeLoveSubTopicStatus extends HomePageEvent {
  final SubTopic subTopic;
  ChangeLoveSubTopicStatus({required this.subTopic});
}

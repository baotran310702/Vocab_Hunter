part of 'practise_vocab_bloc.dart';

abstract class PractiseVocabEvent {}

class PractiseVocabInitial extends PractiseVocabEvent {
  final List<VocabularyByTopic>? vocabularies;
  PractiseVocabInitial({this.vocabularies});
}

class PractiseVocabTopicInitial extends PractiseVocabEvent {
  final String subTopicId;
  PractiseVocabTopicInitial({required this.subTopicId});
}

class SubmitAnswerTopicVocab extends PractiseVocabEvent {
  final String answer;
  SubmitAnswerTopicVocab({required this.answer});
}

class ChangeNextQuestionTopicVocab extends PractiseVocabEvent {
  final bool isTrue;
  ChangeNextQuestionTopicVocab({required this.isTrue});
}

class ChangeVocabList extends PractiseVocabEvent {
  final String listId;
  ChangeVocabList({required this.listId});
}

class SubmitAnswer extends PractiseVocabEvent {
  final String answer;
  SubmitAnswer({required this.answer});
}

class ChangeNextQuestion extends PractiseVocabEvent {
  final bool isTrue;

  ChangeNextQuestion({required this.isTrue});
}

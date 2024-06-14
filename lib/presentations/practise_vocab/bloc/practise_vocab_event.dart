part of 'practise_vocab_bloc.dart';

abstract class PractiseVocabEvent {}

class PractiseVocabInitial extends PractiseVocabEvent {
  final List<VocabularyByTopic>? vocabularies;
  PractiseVocabInitial({this.vocabularies});
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

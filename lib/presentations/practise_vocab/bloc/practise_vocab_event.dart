part of 'practise_vocab_bloc.dart';

abstract class PractiseVocabEvent {}

class PractiseVocabInitial extends PractiseVocabEvent {
  PractiseVocabInitial();
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
  ChangeNextQuestion();
}

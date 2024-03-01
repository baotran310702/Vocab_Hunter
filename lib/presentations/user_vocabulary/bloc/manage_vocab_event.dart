part of 'manage_vocab_bloc.dart';

abstract class ManageVocabEvent {}

class AddVocabEvent extends ManageVocabEvent {
  final String word;

  AddVocabEvent({required this.word});
}

class RemoveVocabEvent extends ManageVocabEvent {
  final String word;
  RemoveVocabEvent({required this.word});
}

class UpdateVocabEvent extends ManageVocabEvent {
  final String word;
  final String meaning;
  UpdateVocabEvent({required this.word, required this.meaning});
}

class ClearVocabEvent extends ManageVocabEvent {}

class LoadVocabEvent extends ManageVocabEvent {}

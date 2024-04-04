part of 'manage_vocab_bloc.dart';

abstract class ManageVocabEvent {}

class AddVocabEvent extends ManageVocabEvent {
  final Vocabulary word;

  AddVocabEvent({required this.word});
}

class RemoveVocabEvent extends ManageVocabEvent {
  final String word;
  RemoveVocabEvent({required this.word});
}

class UpdateVocabEvent extends ManageVocabEvent {
  final Vocabulary word;
  UpdateVocabEvent({required this.word});
}

class ClearVocabEvent extends ManageVocabEvent {}

class LoadVocabEvent extends ManageVocabEvent {
  final String inputVocab;

  LoadVocabEvent({required this.inputVocab});
}

class GetSimilarityVocabEvent extends ManageVocabEvent {
  final String inputVocab;

  GetSimilarityVocabEvent({required this.inputVocab});
}

class GetMeaningVocab extends ManageVocabEvent {
  final String inputVocab;
  GetMeaningVocab({required this.inputVocab});
}

class GetSimilarityVocabLocalEvent extends ManageVocabEvent {
  final String inputVocab;
  GetSimilarityVocabLocalEvent({required this.inputVocab});
}

class GetSimilarVocabModel extends ManageVocabEvent {
  final String inputVocab;
  GetSimilarVocabModel({required this.inputVocab});
}

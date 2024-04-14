part of 'manage_vocab_bloc.dart';

abstract class ManageVocabEvent {}

class InitUserVocabEvent extends ManageVocabEvent {}

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

class ClearRecommendVocabEvent extends ManageVocabEvent {}

class AddNewListVocabEvent extends ManageVocabEvent {
  final String nameList;
  final List<String> listVocab;
  AddNewListVocabEvent({
    required this.listVocab,
    required this.nameList,
  });
}

class AddNewListLearningVocab extends ManageVocabEvent {
  final String name;
  AddNewListLearningVocab({required this.name});
}

class DeleteListLearningVocab extends ManageVocabEvent {
  final String listId;
  DeleteListLearningVocab({required this.listId});
}

class AddVocabToListLearning extends ManageVocabEvent {
  final VocabularyRemote vocab;
  AddVocabToListLearning({required this.vocab});
}

class RemoveFromListLearning extends ManageVocabEvent {
  final VocabularyRemote vocab;

  RemoveFromListLearning({required this.vocab});
}

class DeleteVocabFromListLearning extends ManageVocabEvent {
  final String listId;
  DeleteVocabFromListLearning({required this.listId});
}

class UpdateListLearningVocab extends ManageVocabEvent {
  final String listId;
  final String listName;
  UpdateListLearningVocab({required this.listId, required this.listName});
}

class SetDefaultListLearningVocab extends ManageVocabEvent {
  final String listId;
  SetDefaultListLearningVocab({required this.listId});
}

class SyncUserData extends ManageVocabEvent {}

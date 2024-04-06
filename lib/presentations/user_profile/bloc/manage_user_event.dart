part of 'manage_user_bloc.dart';

abstract class ManageUserEvents {}

class InitUserEvent extends ManageUserEvents {
  InitUserEvent();
}

class CreateListVocab extends ManageUserEvents {}

class AddVocabToList extends ManageUserEvents {
  final String vocab;
  AddVocabToList({required this.vocab});
}

class RemoveVocabFromList extends ManageUserEvents {
  final String vocab;
  RemoveVocabFromList({required this.vocab});
}

class EditVocabList extends ManageUserEvents {
  final String vocab;
  EditVocabList({required this.vocab});
}

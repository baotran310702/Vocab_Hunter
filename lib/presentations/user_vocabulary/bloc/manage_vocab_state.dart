part of 'manage_vocab_bloc.dart';

class ManageVocabState extends Equatable {
  final List<Vocabulary> vocabList;
  final bool isLoading;
  final String error;

  ManageVocabState({
    required this.vocabList,
    required this.isLoading,
    required this.error,
  });

  factory ManageVocabState.initial() {
    return ManageVocabState(
      vocabList: [],
      isLoading: false,
      error: '',
    );
  }

  ManageVocabState copyWith({
    List<Vocabulary>? vocabList,
    bool? isLoading,
    String? error,
  }) {
    return ManageVocabState(
      vocabList: vocabList ?? this.vocabList,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

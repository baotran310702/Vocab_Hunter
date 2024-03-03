part of 'manage_vocab_bloc.dart';

class ManageVocabState extends Equatable {
  final List<Vocabulary> vocabList;
  final List<Vocabulary> similarVocabs;
  final bool isLoading;
  final String error;

  const ManageVocabState({
    required this.vocabList,
    required this.isLoading,
    required this.error,
    required this.similarVocabs,
  });

  factory ManageVocabState.initial() {
    return const ManageVocabState(
      vocabList: [],
      similarVocabs: [],
      isLoading: false,
      error: '',
    );
  }

  ManageVocabState copyWith({
    List<Vocabulary>? vocabList,
    List<Vocabulary>? similarVocabs,
    bool? isLoading,
    String? error,
  }) {
    return ManageVocabState(
      vocabList: vocabList ?? this.vocabList,
      similarVocabs: similarVocabs ?? this.similarVocabs,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [vocabList, isLoading, error];
}

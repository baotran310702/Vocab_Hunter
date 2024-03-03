part of 'manage_vocab_bloc.dart';

class ManageVocabState extends Equatable {
  final List<Vocabulary> vocabList;
  final List<Vocab> similarVocabs;
  final String meaningRecommendVocabs;
  final bool isLoading;
  final String error;

  const ManageVocabState({
    required this.vocabList,
    required this.isLoading,
    required this.error,
    required this.similarVocabs,
    this.meaningRecommendVocabs = "",
  });

  factory ManageVocabState.initial() {
    return const ManageVocabState(
      vocabList: [],
      similarVocabs: [],
      meaningRecommendVocabs: "",
      isLoading: false,
      error: '',
    );
  }

  ManageVocabState copyWith({
    List<Vocabulary>? vocabList,
    List<Vocab>? similarVocabs,
    String? meaningRecommendVocabs,
    bool? isLoading,
    String? error,
  }) {
    return ManageVocabState(
      vocabList: vocabList ?? this.vocabList,
      similarVocabs: similarVocabs ?? this.similarVocabs,
      meaningRecommendVocabs: meaningRecommendVocabs ?? this.meaningRecommendVocabs,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [vocabList,meaningRecommendVocabs , similarVocabs, isLoading, error];
}

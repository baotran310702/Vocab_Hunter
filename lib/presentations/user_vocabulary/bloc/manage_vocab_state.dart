part of 'manage_vocab_bloc.dart';

class ManageVocabState extends Equatable {
  final List<Vocabulary> vocabList;
  final List<(VocabularyRemote, VocabularyRemote)> vocabRemoteList;
  final List<VocabWordSimilarity> similarVocabs;
  final String meaningRecommendVocabs;
  final bool isLoading;
  final String error;

  const ManageVocabState({
    required this.vocabList,
    required this.isLoading,
    required this.error,
    required this.similarVocabs,
    required this.vocabRemoteList,
    this.meaningRecommendVocabs = "",
  });

  factory ManageVocabState.initial() {
    return const ManageVocabState(
      vocabList: [],
      similarVocabs: [],
      vocabRemoteList: [],
      meaningRecommendVocabs: "",
      isLoading: false,
      error: '',
    );
  }

  ManageVocabState copyWith({
    List<Vocabulary>? vocabList,
    List<VocabWordSimilarity>? similarVocabs,
    List<(VocabularyRemote, VocabularyRemote)>? vocabRemoteList,
    String? meaningRecommendVocabs,
    bool? isLoading,
    String? error,
  }) {
    return ManageVocabState(
      vocabList: vocabList ?? this.vocabList,
      similarVocabs: similarVocabs ?? this.similarVocabs,
      meaningRecommendVocabs:
          meaningRecommendVocabs ?? this.meaningRecommendVocabs,
      vocabRemoteList: vocabRemoteList ?? this.vocabRemoteList,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        vocabList,
        meaningRecommendVocabs,
        vocabRemoteList,
        similarVocabs,
        isLoading,
        error
      ];
}

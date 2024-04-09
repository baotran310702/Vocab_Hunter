part of 'manage_vocab_bloc.dart';

class ManageVocabState extends Equatable {
  final UserModel userModel;
  final List<Vocabulary> vocabList;
  final List<(VocabularyRemote, VocabularyRemote)> vocabRemoteList;
  final List<VocabWordSimilarity> similarVocabs;
  final List<VocabWordSimilarity> similarVocabsLocal;
  final String meaningRecommendVocabs;
  final bool isLoading;
  final bool isSync;
  final String error;

  const ManageVocabState({
    required this.userModel,
    required this.vocabList,
    required this.isLoading,
    required this.error,
    required this.similarVocabs,
    required this.similarVocabsLocal,
    required this.vocabRemoteList,
    required this.isSync,
    this.meaningRecommendVocabs = "",
  });

  factory ManageVocabState.initial() {
    return ManageVocabState(
      userModel: UserModel.empty(),
      vocabList: const [],
      similarVocabs: const [],
      vocabRemoteList: const [],
      similarVocabsLocal: const [],
      meaningRecommendVocabs: "",
      isLoading: false,
      isSync: false,
      error: '',
    );
  }

  ManageVocabState copyWith({
    UserModel? userModel,
    List<Vocabulary>? vocabList,
    List<VocabWordSimilarity>? similarVocabs,
    List<VocabWordSimilarity>? similarVocabsLocal,
    List<(VocabularyRemote, VocabularyRemote)>? vocabRemoteList,
    String? meaningRecommendVocabs,
    bool? isLoading,
    bool? isSync,
    String? error,
  }) {
    return ManageVocabState(
      userModel: userModel ?? this.userModel,
      vocabList: vocabList ?? this.vocabList,
      similarVocabs: similarVocabs ?? this.similarVocabs,
      similarVocabsLocal: similarVocabsLocal ?? this.similarVocabsLocal,
      meaningRecommendVocabs:
          meaningRecommendVocabs ?? this.meaningRecommendVocabs,
      vocabRemoteList: vocabRemoteList ?? this.vocabRemoteList,
      isLoading: isLoading ?? this.isLoading,
      isSync: isSync ?? this.isSync,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        userModel,
        vocabList,
        meaningRecommendVocabs,
        vocabRemoteList,
        similarVocabsLocal,
        similarVocabs,
        isLoading,
        isSync,
        error
      ];
}

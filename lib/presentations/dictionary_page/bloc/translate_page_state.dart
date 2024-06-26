part of 'translate_page_bloc.dart';

class TranslatePageState extends Equatable {
  final bool isLoading;
  final bool? isLocal;
  final Vocabulary currentVocabulary;
  final List<Vocabulary> searchedVocabulary;
  final (VocabularyRemote, VocabularyRemote)? currentVocabularyRemote;
  final ListVocabTranslated listVocabTranslated;

  //required params
  const TranslatePageState({
    required this.isLoading,
    required this.currentVocabulary,
    required this.searchedVocabulary,
    this.isLocal,
    this.currentVocabularyRemote,
    required this.listVocabTranslated,
  });

  //initial state
  factory TranslatePageState.initial() => TranslatePageState(
        isLoading: false,
        currentVocabulary: Vocabulary.empty(),
        searchedVocabulary: const [],
        isLocal: false,
        currentVocabularyRemote: null,
        listVocabTranslated: ListVocabTranslated.empty(),
      );

  //copyWith method

  TranslatePageState copyWith({
    bool? isLoading,
    Vocabulary? currentVocabulary,
    List<Vocabulary>? searchedVocabulary,
    bool? isLocal,
    (VocabularyRemote, VocabularyRemote)? currentVocabularyRemote,
    ListVocabTranslated? listVocabTranslated,
  }) {
    return TranslatePageState(
      isLoading: isLoading ?? this.isLoading,
      currentVocabulary: currentVocabulary ?? this.currentVocabulary,
      searchedVocabulary: searchedVocabulary ?? this.searchedVocabulary,
      isLocal: isLocal ?? this.isLocal,
      currentVocabularyRemote:
          currentVocabularyRemote ?? this.currentVocabularyRemote,
      listVocabTranslated: listVocabTranslated ?? this.listVocabTranslated,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        currentVocabulary,
        searchedVocabulary,
        isLocal,
        currentVocabularyRemote,
        listVocabTranslated,
      ];
}

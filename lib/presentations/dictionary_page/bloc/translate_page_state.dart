part of 'translate_page_bloc.dart';

class TranslatePageState extends Equatable {
  final bool isLoading;
  final bool? isLocal;
  final Vocabulary currentVocabulary;
  final List<Vocabulary> searchedVocabulary;

  //required params
  const TranslatePageState({
    required this.isLoading,
    required this.currentVocabulary,
    required this.searchedVocabulary,
    this.isLocal,
  });

  //initial state
  factory TranslatePageState.initial() => TranslatePageState(
        isLoading: false,
        currentVocabulary: Vocabulary.empty(),
        searchedVocabulary: const [],
        isLocal: false,
      );

  //copyWith method

  TranslatePageState copyWith({
    bool? isLoading,
    Vocabulary? currentVocabulary,
    List<Vocabulary>? searchedVocabulary,
    bool? isLocal,
  }) {
    return TranslatePageState(
      isLoading: isLoading ?? this.isLoading,
      currentVocabulary: currentVocabulary ?? this.currentVocabulary,
      searchedVocabulary: searchedVocabulary ?? this.searchedVocabulary,
      isLocal: isLocal ?? this.isLocal,
    );
  }

  @override
  List<Object?> get props => [isLoading, currentVocabulary, searchedVocabulary];
}

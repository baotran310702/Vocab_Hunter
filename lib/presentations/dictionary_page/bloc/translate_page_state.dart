part of 'translate_page_bloc.dart';

class TranslatePageState extends Equatable {
  final bool isLoading;
  final Vocabulary currentVocabulary;

  //required params
  const TranslatePageState({
    required this.isLoading,
    required this.currentVocabulary,
  });

  //initial state
  factory TranslatePageState.initial() => TranslatePageState(
        isLoading: false,
        currentVocabulary: Vocabulary.empty(),
      );

  //copyWith method

  TranslatePageState copyWith({
    bool? isLoading,
    Vocabulary? currentVocabulary,
  }) {
    return TranslatePageState(
      isLoading: isLoading ?? this.isLoading,
      currentVocabulary: currentVocabulary ?? this.currentVocabulary,
    );
  }

  @override
  List<Object?> get props => [isLoading, currentVocabulary];
}

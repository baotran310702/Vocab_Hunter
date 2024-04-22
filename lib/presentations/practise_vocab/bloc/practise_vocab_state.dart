part of 'practise_vocab_bloc.dart';

class PractiseVocabState extends Equatable {
  final bool isLoading;
  final UserModel currentUser;
  final String currentListId;
  final int currentQuestionIndex;
  final List<VocabularyRemote> questionList;
  final List<VocabularyRemote> answeredList;

  const PractiseVocabState({
    required this.isLoading,
    required this.currentUser,
    required this.currentQuestionIndex,
    required this.currentListId,
    required this.questionList,
    required this.answeredList,
  });

  factory PractiseVocabState.initial() {
    return PractiseVocabState(
      isLoading: false,
      currentUser: UserModel.empty(),
      currentQuestionIndex: 0,
      currentListId: "",
      questionList: const [],
      answeredList: const [],
    );
  }

  // copy with
  PractiseVocabState copyWith({
    bool? isLoading,
    UserModel? currentUser,
    String? currentListId,
    int? currentQuestionIndex,
    List<VocabularyRemote>? questionList,
    List<VocabularyRemote>? answeredList,
  }) {
    return PractiseVocabState(
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      currentListId: currentListId ?? this.currentListId,
      questionList: questionList ?? this.questionList,
      answeredList: answeredList ?? this.answeredList,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        currentUser,
        currentQuestionIndex,
        currentListId,
        questionList,
        answeredList,
      ];
}

class AnswerResult extends PractiseVocabState {
  final String message;
  const AnswerResult({
    required this.message,
    required bool isLoading,
    required int currentQuestionIndex,
    required UserModel currentUser,
    required String currentListId,
    required List<VocabularyRemote> questionList,
    required List<VocabularyRemote> answeredList,
  }) : super(
          isLoading: isLoading,
          currentUser: currentUser,
          currentQuestionIndex: currentQuestionIndex,
          currentListId: currentListId,
          questionList: questionList,
          answeredList: answeredList,
        );
}

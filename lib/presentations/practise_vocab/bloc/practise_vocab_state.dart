part of 'practise_vocab_bloc.dart';

class PractiseVocabState extends Equatable {
  final bool isLoading;
  final UserModel currentUser;
  final String currentListId;
  final int currentQuestionIndex;
  final List<(VocabularyRemote, VocabularyRemote)> questionList;
  final List<(VocabularyRemote, VocabularyRemote)> correctAnswerList;
  final List<(VocabularyRemote, VocabularyRemote)> failedAnswerList;

  const PractiseVocabState({
    required this.isLoading,
    required this.currentUser,
    required this.currentQuestionIndex,
    required this.currentListId,
    required this.questionList,
    required this.correctAnswerList,
    required this.failedAnswerList,
  });

  factory PractiseVocabState.initial() {
    return PractiseVocabState(
      isLoading: false,
      currentUser: UserModel.empty(),
      currentQuestionIndex: 0,
      currentListId: "",
      questionList: const [],
      correctAnswerList: const [],
      failedAnswerList: const [],
    );
  }

  // copy with
  PractiseVocabState copyWith({
    bool? isLoading,
    UserModel? currentUser,
    String? currentListId,
    int? currentQuestionIndex,
    List<(VocabularyRemote, VocabularyRemote)>? questionList,
    List<(VocabularyRemote, VocabularyRemote)>? correctAnswerList,
    List<(VocabularyRemote, VocabularyRemote)>? failedAnswerList,
  }) {
    return PractiseVocabState(
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      currentListId: currentListId ?? this.currentListId,
      questionList: questionList ?? this.questionList,
      correctAnswerList: correctAnswerList ?? this.correctAnswerList,
      failedAnswerList: failedAnswerList ?? this.failedAnswerList,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        currentUser,
        currentQuestionIndex,
        currentListId,
        questionList,
        correctAnswerList,
        failedAnswerList,
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
    required List<(VocabularyRemote, VocabularyRemote)> questionList,
    required List<(VocabularyRemote, VocabularyRemote)> correctAnswerList,
    required List<(VocabularyRemote, VocabularyRemote)> failedAnswerList,
  }) : super(
          isLoading: isLoading,
          currentUser: currentUser,
          currentQuestionIndex: currentQuestionIndex,
          currentListId: currentListId,
          questionList: questionList,
          correctAnswerList: correctAnswerList,
          failedAnswerList: failedAnswerList,
        );
}

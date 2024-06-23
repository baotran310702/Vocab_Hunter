part of 'practise_vocab_bloc.dart';

class PractiseVocabState extends Equatable {
  final bool isLoading;
  final UserModel currentUser;
  final String currentListId;
  final int currentQuestionIndex;
  final Map<String, String> sentences;

  // question list for each list
  final List<(VocabularyRemote, VocabularyRemote)> questionList;
  final List<(VocabularyRemote, VocabularyRemote)> correctAnswerList;
  final List<(VocabularyRemote, VocabularyRemote)> failedAnswerList;

  // question for topic vocab local
  final List<VocabTopic> questionTopicVocabList;
  final List<VocabTopic> correctAnswerTopicVocabList;
  final List<VocabTopic> failedAnswerTopicVocabList;

  //summarize result
  final List<SummarizeResult> summarizeResult;

  const PractiseVocabState({
    required this.isLoading,
    required this.currentUser,
    required this.currentQuestionIndex,
    required this.sentences,
    required this.currentListId,
    required this.questionList,
    required this.correctAnswerList,
    required this.failedAnswerList,
    required this.questionTopicVocabList,
    required this.correctAnswerTopicVocabList,
    required this.failedAnswerTopicVocabList,
    required this.summarizeResult,
  });

  factory PractiseVocabState.initial() {
    return PractiseVocabState(
      isLoading: false,
      currentUser: UserModel.empty(),
      currentQuestionIndex: 0,
      currentListId: "",
      sentences: const {},
      questionList: const [],
      correctAnswerList: const [],
      failedAnswerList: const [],
      questionTopicVocabList: const [],
      correctAnswerTopicVocabList: const [],
      failedAnswerTopicVocabList: const [],
      summarizeResult: const [],
    );
  }

  // copy with
  PractiseVocabState copyWith({
    bool? isLoading,
    UserModel? currentUser,
    String? currentListId,
    int? currentQuestionIndex,
    Map<String, String>? sentences,
    List<(VocabularyRemote, VocabularyRemote)>? questionList,
    List<(VocabularyRemote, VocabularyRemote)>? correctAnswerList,
    List<(VocabularyRemote, VocabularyRemote)>? failedAnswerList,
    List<VocabTopic>? questionTopicVocabList,
    List<VocabTopic>? correctAnswerTopicVocabList,
    List<VocabTopic>? failedAnswerTopicVocabList,
    List<SummarizeResult>? summarizeResult,
  }) {
    return PractiseVocabState(
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      currentListId: currentListId ?? this.currentListId,
      sentences: sentences ?? this.sentences,
      questionList: questionList ?? this.questionList,
      correctAnswerList: correctAnswerList ?? this.correctAnswerList,
      failedAnswerList: failedAnswerList ?? this.failedAnswerList,
      questionTopicVocabList:
          questionTopicVocabList ?? this.questionTopicVocabList,
      correctAnswerTopicVocabList:
          correctAnswerTopicVocabList ?? this.correctAnswerTopicVocabList,
      failedAnswerTopicVocabList:
          failedAnswerTopicVocabList ?? this.failedAnswerTopicVocabList,
      summarizeResult: summarizeResult ?? this.summarizeResult,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        currentUser,
        currentQuestionIndex,
        sentences,
        currentListId,
        questionList,
        correctAnswerList,
        failedAnswerList,
        questionTopicVocabList,
        correctAnswerTopicVocabList,
        failedAnswerTopicVocabList,
        summarizeResult,
      ];
}

class AnswerResult extends PractiseVocabState {
  final String message;
  final bool isTopicVocab;
  const AnswerResult({
    required super.summarizeResult,
    required this.message,
    required this.isTopicVocab,
    required bool isLoading,
    required int currentQuestionIndex,
    required UserModel currentUser,
    required Map<String, String> sentences,
    required String currentListId,
    required List<(VocabularyRemote, VocabularyRemote)> questionList,
    required List<(VocabularyRemote, VocabularyRemote)> correctAnswerList,
    required List<(VocabularyRemote, VocabularyRemote)> failedAnswerList,
    required List<VocabTopic> questionTopicVocabList,
    required List<VocabTopic> correctAnswerTopicVocabList,
    required List<VocabTopic> failedAnswerTopicVocabList,
  }) : super(
          isLoading: isLoading,
          currentUser: currentUser,
          currentQuestionIndex: currentQuestionIndex,
          currentListId: currentListId,
          questionList: questionList,
          correctAnswerList: correctAnswerList,
          failedAnswerList: failedAnswerList,
          sentences: sentences,
          questionTopicVocabList: questionTopicVocabList,
          correctAnswerTopicVocabList: correctAnswerTopicVocabList,
          failedAnswerTopicVocabList: failedAnswerTopicVocabList,
        );
  //override copywith
  @override
  AnswerResult copyWith({
    List<SummarizeResult>? summarizeResult,
    String? message,
    bool? isTopicVocab,
    bool? isLoading,
    UserModel? currentUser,
    int? currentQuestionIndex,
    Map<String, String>? sentences,
    String? currentListId,
    List<(VocabularyRemote, VocabularyRemote)>? questionList,
    List<(VocabularyRemote, VocabularyRemote)>? correctAnswerList,
    List<(VocabularyRemote, VocabularyRemote)>? failedAnswerList,
    List<VocabTopic>? questionTopicVocabList,
    List<VocabTopic>? correctAnswerTopicVocabList,
    List<VocabTopic>? failedAnswerTopicVocabList,
  }) {
    return AnswerResult(
      summarizeResult: summarizeResult ?? this.summarizeResult,
      message: message ?? this.message,
      isTopicVocab: isTopicVocab ?? this.isTopicVocab,
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      sentences: sentences ?? this.sentences,
      currentListId: currentListId ?? this.currentListId,
      questionList: questionList ?? this.questionList,
      correctAnswerList: correctAnswerList ?? this.correctAnswerList,
      failedAnswerList: failedAnswerList ?? this.failedAnswerList,
      questionTopicVocabList:
          questionTopicVocabList ?? this.questionTopicVocabList,
      correctAnswerTopicVocabList:
          correctAnswerTopicVocabList ?? this.correctAnswerTopicVocabList,
      failedAnswerTopicVocabList:
          failedAnswerTopicVocabList ?? this.failedAnswerTopicVocabList,
    );
  }

  @override
  List<Object?> get props => [
        summarizeResult,
        message,
        isTopicVocab,
        isLoading,
        currentUser,
        currentQuestionIndex,
        sentences,
        currentListId,
        questionList,
        correctAnswerList,
        failedAnswerList,
        questionTopicVocabList,
        correctAnswerTopicVocabList,
        failedAnswerTopicVocabList,
      ];
}

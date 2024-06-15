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
      ];
}

class AnswerResult extends PractiseVocabState {
  final String message;
  const AnswerResult({
    required this.message,
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
}

import 'dart:math';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/models/vocabulary/vocab_topic.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/models/vocabulary_topic/list_vocabulary_topic.dart';
import 'package:english_learner/models/vocabulary_topic/vocabulary_topic.dart';
import 'package:english_learner/models/word_notification.dart';
import 'package:english_learner/repository/gemini_repository.dart';
import 'package:english_learner/repository/vocab_repository.dart';
import 'package:english_learner/services/user_hive_local.dart';
import 'package:english_learner/services/word_notification_local.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'practise_vocab_event.dart';
part 'practise_vocab_state.dart';

class PractiseVocabBloc extends Bloc<PractiseVocabEvent, PractiseVocabState> {
  final GeminiRepository geminiRepository = GeminiRepository();
  final VocabRepository vocabRepository = VocabRepository();
  PractiseVocabBloc() : super(PractiseVocabState.initial()) {
    on<PractiseVocabInitial>(_onPractiseVocabInit);
    on<ChangeVocabList>(_onChangeVocabList);
    on<ChangeNextQuestion>(
      _onChangeNextQuestion,
      transformer: droppable(),
    );
    on<PractiseVocabTopicInitial>(_onPractiseVocabTopicInit);
    on<ChangeNextQuestionTopicVocab>(
      _onChangeNextQuestionTopicVocab,
      transformer: droppable(),
    );
  }

  _onChangeNextQuestionTopicVocab(
      ChangeNextQuestionTopicVocab event, Emitter emit) async {
    if (state.currentQuestionIndex == state.questionTopicVocabList.length - 1) {
      List<VocabTopic> currentAnswerList = event.isTrue
          ? List.from(state.correctAnswerTopicVocabList)
          : List.from(state.failedAnswerTopicVocabList);
      currentAnswerList
          .add(state.questionTopicVocabList[state.currentQuestionIndex]);

      await Future.wait([
        ...state.correctAnswerTopicVocabList
            .map((e) => _updateNotificationList((
                  VocabularyRemote.convertFromVocabTopic(
                      vocabTopic: e, isVietNamese: false),
                  VocabularyRemote.convertFromVocabTopic(
                      vocabTopic: e, isVietNamese: true),
                ), true))
            .toList(),
        ...state.failedAnswerTopicVocabList
            .map((e) => _updateNotificationList((
                  VocabularyRemote.convertFromVocabTopic(
                      vocabTopic: e, isVietNamese: false),
                  VocabularyRemote.convertFromVocabTopic(
                      vocabTopic: e, isVietNamese: true),
                ), true))
            .toList(),
      ]);

      emit(
        AnswerResult(
          message: "Congratulations!",
          isTopicVocab: true,
          isLoading: state.isLoading,
          currentQuestionIndex: state.currentQuestionIndex,
          currentUser: state.currentUser,
          currentListId: state.currentListId,
          questionList: state.questionList,
          correctAnswerList: state.correctAnswerList,
          failedAnswerList: state.failedAnswerList,
          sentences: state.sentences,
          questionTopicVocabList: state.questionTopicVocabList,
          correctAnswerTopicVocabList: event.isTrue
              ? currentAnswerList
              : state.correctAnswerTopicVocabList,
          failedAnswerTopicVocabList: event.isTrue
              ? state.failedAnswerTopicVocabList
              : currentAnswerList,
        ),
      );

      return;
    }
    if (event.isTrue) {
      List<VocabTopic> newCorrectVocabTopicList =
          List.from(state.correctAnswerTopicVocabList);
      newCorrectVocabTopicList
          .add(state.questionTopicVocabList[state.currentQuestionIndex]);



      emit(state.copyWith(
          correctAnswerTopicVocabList: newCorrectVocabTopicList,
          currentQuestionIndex: state.currentQuestionIndex + 1));
    } else {
      List<VocabTopic> newFailedVocabTopicList =
          List.from(state.failedAnswerTopicVocabList);
      newFailedVocabTopicList
          .add(state.questionTopicVocabList[state.currentQuestionIndex]);


      emit(
        state.copyWith(
            failedAnswerTopicVocabList: newFailedVocabTopicList,
            currentQuestionIndex: state.currentQuestionIndex + 1),
      );
    }
  }

  _onPractiseVocabTopicInit(
      PractiseVocabTopicInitial event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    ListVocabularyTopic listVocabTopicLocal = await vocabRepository
        .getOneListTopicVocabularyTopicLocal(subTopicId: event.subTopicId);

    List<VocabTopic> tempList =
        List.from(listVocabTopicLocal.vocabularyByTopic);

    tempList.shuffle();

    int blankWordListLenth = tempList.length ~/ 3;

    List<VocabTopic> currentFillBlankWords = [];
    for (int i = 0; i < blankWordListLenth; i++) {
      int index = Random().nextInt(tempList.length);
      if (currentFillBlankWords
              .indexWhere((element) => element.word == tempList[index].word) !=
          -1) {
        i--;
        continue;
      }
      currentFillBlankWords.add(tempList[index]);
    }

    /// init sentences for filling question

    Map<String, String> sentences = {};

    for (int i = 0; i < currentFillBlankWords.length; i++) {
      sentences.addAll({
        currentFillBlankWords[i].word: currentFillBlankWords[i].exampleEnglish
      });
    }

    emit(state.copyWith(
      isLoading: false,
      questionTopicVocabList: listVocabTopicLocal.vocabularyByTopic,
      sentences: sentences,
      currentQuestionIndex: 1,
    ));
  }

  _onPractiseVocabInit(PractiseVocabInitial event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    UserModel currentUserModel = await UserHiveLocal().getUser();

    List<(VocabularyRemote, VocabularyRemote)> questionList = [];
    for (var item in currentUserModel.learningWords) {
      for (int i = 0; item.listVocabulary.entries.first.value.length > i; i++) {
        questionList.add((
          item.listVocabulary.entries.first.value[i],
          item.listVocabulary.entries.last.value[i]
        ));
      }
    }
    questionList.shuffle();

    int blankWordListLenth = questionList.length ~/ 3;
    List<String> currentFillBlankWords = [];
    for (int i = 0; i < blankWordListLenth; i++) {
      int index = Random().nextInt(questionList.length);
      if (currentFillBlankWords.contains(questionList[index].$1.word ?? "") ||
          questionList[index].$1.word == null) {
        i--;
        continue;
      }
      currentFillBlankWords.add(questionList[index].$1.word ?? "");
    }

    int maxTry = 3;
    int temp = 0;
    Map<String, String> sentences = {};
    while (temp < maxTry) {
      var listSentences = await Future.wait(
        currentFillBlankWords.map(
          (e) => geminiRepository.getExampleSentencesVocab(e),
        ),
      );

      for (int i = 0; i < currentFillBlankWords.length; i++) {
        sentences.addAll({currentFillBlankWords[i]: listSentences[i]});
      }
      if (sentences.isNotEmpty) break;
      temp++;
    }

    emit(state.copyWith(
      isLoading: false,
      currentUser: currentUserModel,
      questionList: questionList,
      currentListId: "*",
      currentQuestionIndex: 1,
      sentences: sentences,
    ));
  }

  _onChangeVocabList(ChangeVocabList event, Emitter emit) {
    if (event.listId == "*") {
      List<(VocabularyRemote, VocabularyRemote)> questionList = [];
      for (var item in state.currentUser.learningWords) {
        for (int i = 0;
            item.listVocabulary.entries.first.value.length > i;
            i++) {
          questionList.add((
            item.listVocabulary.entries.first.value[i],
            item.listVocabulary.entries.last.value[i]
          ));
        }
      }
      questionList.shuffle();
      emit(state.copyWith(
        currentListId: event.listId,
        questionList: questionList,
        currentQuestionIndex: 1,
      ));
      return;
    }

    UserVocab filteredUserVocab = state.currentUser.learningWords
        .firstWhere((element) => element.listId == event.listId);

    List<(VocabularyRemote, VocabularyRemote)> filteredQuestion = [];
    for (int i = 0;
        filteredUserVocab.listVocabulary.entries.first.value.length > i;
        i++) {
      filteredQuestion.add((
        filteredUserVocab.listVocabulary.entries.first.value[i],
        filteredUserVocab.listVocabulary.entries.last.value[i]
      ));
    }
    emit(
      state.copyWith(
        currentListId: event.listId,
        questionList: filteredQuestion,
      ),
    );
  }

  _onChangeNextQuestion(ChangeNextQuestion event, Emitter emit) async {
    if (state.currentQuestionIndex == state.questionList.length - 1) {
      List<(VocabularyRemote, VocabularyRemote)> currentAnswerList =
          event.isTrue
              ? List.from(state.correctAnswerList)
              : List.from(state.failedAnswerList);
      currentAnswerList.add(state.questionList[state.currentQuestionIndex]);

      await Future.wait([
        ...state.correctAnswerList
            .map((e) => _updateNotificationList((e.$1, e.$2), true))
            .toList(),
        ...state.failedAnswerList
            .map((e) => _updateNotificationList((e.$1, e.$2), false))
            .toList(),
      ]);

      emit(
        AnswerResult(
          message: "Congratulations!",
          isLoading: state.isLoading,
          isTopicVocab: false,
          currentQuestionIndex: state.currentQuestionIndex,
          currentUser: state.currentUser,
          currentListId: state.currentListId,
          questionList: state.questionList,
          correctAnswerList:
              event.isTrue ? currentAnswerList : state.correctAnswerList,
          failedAnswerList:
              event.isTrue ? state.failedAnswerList : currentAnswerList,
          sentences: state.sentences,
          questionTopicVocabList: state.questionTopicVocabList,
          correctAnswerTopicVocabList: state.correctAnswerTopicVocabList,
          failedAnswerTopicVocabList: state.failedAnswerTopicVocabList,
        ),
      );

      return;
    }
    if (event.isTrue) {
      List<(VocabularyRemote, VocabularyRemote)> currentAnswerList =
          List.from(state.correctAnswerList);
      currentAnswerList.add(state.questionList[state.currentQuestionIndex]);

      emit(state.copyWith(
          correctAnswerList: currentAnswerList,
          currentQuestionIndex: state.currentQuestionIndex + 1));
    } else {
      List<(VocabularyRemote, VocabularyRemote)> currentAnswerList =
          List.from(state.failedAnswerList);
      currentAnswerList.add(state.questionList[state.currentQuestionIndex]);
      emit(
        state.copyWith(
            failedAnswerList: currentAnswerList,
            currentQuestionIndex: state.currentQuestionIndex + 1),
      );
    }
  }

  //function handle without event.
  Future<void> _updateNotificationList(
      (VocabularyRemote, VocabularyRemote) vocab, bool isCorrect) async {
    ListWordNotification listWordNotification =
        await WordNotificationServices().getListWordNotification();
    List<WordNotification> currentListNotification =
        List.from(listWordNotification.listWordNotification);
    int index = currentListNotification
        .indexWhere((element) => element.englishWords.word == vocab.$1.word);
    if (index != -1) {
      WordNotification newWord = currentListNotification[index].copyWith(
        failureCount: isCorrect
            ? currentListNotification[index].failureCount
            : currentListNotification[index].failureCount + 1,
        successCount: isCorrect
            ? currentListNotification[index].successCount + 1
            : currentListNotification[index].successCount,
      );
      List<WordNotification> newList = currentListNotification
          .map((e) => e.englishWords.word == vocab.$1.word ? newWord : e)
          .toList();
      await WordNotificationServices().updateListWordNotification(
          ListWordNotification(listWordNotification: newList));
      return;
    } else {
      WordNotification newWord = WordNotification(
        englishWords: vocab.$1,
        vietnameseWords: vocab.$2,
        failureCount: isCorrect ? 0 : 1,
        successCount: isCorrect ? 1 : 0,
        thresholdWords: ThresholdWords.lowFailure,
      );
      List<WordNotification> newList = List.from(currentListNotification);
      newList.add(newWord);
      await WordNotificationServices().updateListWordNotification(
          ListWordNotification(listWordNotification: newList));
      return;
    }
  }
}

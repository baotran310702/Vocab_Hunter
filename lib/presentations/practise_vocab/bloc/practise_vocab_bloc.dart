import 'package:english_learner/models/user.dart';
import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/services/user_hive_local.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'practise_vocab_event.dart';
part 'practise_vocab_state.dart';

class PractiseVocabBloc extends Bloc<PractiseVocabEvent, PractiseVocabState> {
  PractiseVocabBloc() : super(PractiseVocabState.initial()) {
    on<PractiseVocabInitial>(_onPractiseVocabInit);
    on<ChangeVocabList>(_onChangeVocabList);
    on<ChangeNextQuestion>(_onChangeNextQuestion);
  }

  _onPractiseVocabInit(PractiseVocabInitial event, Emitter emit) async {
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

    emit(state.copyWith(
      currentUser: currentUserModel,
      questionList: questionList,
      currentListId: "*",
      currentQuestionIndex: 1,
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

  _onChangeNextQuestion(ChangeNextQuestion event, Emitter emit) {
    if (state.currentQuestionIndex == state.questionList.length - 1) {
      List<(VocabularyRemote, VocabularyRemote)> currentAnswerList =
          event.isTrue
              ? List.from(state.correctAnswerList)
              : List.from(state.failedAnswerList);
      currentAnswerList.add(state.questionList[state.currentQuestionIndex]);
      emit(
        AnswerResult(
          message: "Congratulations!",
          isLoading: state.isLoading,
          currentQuestionIndex: state.currentQuestionIndex,
          currentUser: state.currentUser,
          currentListId: state.currentListId,
          questionList: state.questionList,
          correctAnswerList:
              event.isTrue ? currentAnswerList : state.correctAnswerList,
          failedAnswerList:
              event.isTrue ? state.failedAnswerList : currentAnswerList,
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
}

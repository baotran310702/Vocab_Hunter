import 'package:english_learner/models/user.dart';
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

    List<VocabularyRemote> questionList = currentUserModel.learningWords
        .expand((element) => element.listVocabulary.entries.first.value)
        .toList();
    questionList.shuffle();

    emit(state.copyWith(
      currentUser: currentUserModel,
      questionList: questionList,
      currentListId: "*",
    ));
  }

  _onChangeVocabList(ChangeVocabList event, Emitter emit) {
    if (event.listId == "*") {
      List<VocabularyRemote> questionList = state.currentUser.learningWords
          .expand((element) => element.listVocabulary.entries.first.value)
          .toList();
      questionList.shuffle();
      emit(state.copyWith(
        currentListId: event.listId,
        questionList: questionList,
        currentQuestionIndex: 0,
      ));
      return;
    }
    emit(state.copyWith(
      currentListId: event.listId,
    ));
  }

  _onChangeNextQuestion(ChangeNextQuestion event, Emitter emit) {
    emit(state.copyWith(currentQuestionIndex: state.currentQuestionIndex + 1));
  }
}

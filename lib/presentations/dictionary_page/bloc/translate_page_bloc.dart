import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:english_learner/models/vocabulary/vocabulary.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';

import 'package:english_learner/repository/translate_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'translate_page_event.dart';
part 'translate_page_state.dart';

class TranslatePageBloc extends Bloc<TranslateEvent, TranslatePageState> {
  final TranslateRepository _translateRepository = TranslateRepository();

  TranslatePageBloc() : super(TranslatePageState.initial()) {
    on<TranslateWordEvent>(_onTranslateWord);
    on<TranslateWordLocal>(_onTranslateWordLocal);
    on<LoadingSearch>(_onLoadingSearch, transformer: droppable());
    on<TranslateWordRemote>(__onTranslateWordRemote);
  }

  _onTranslateWord(TranslateWordEvent event, Emitter<TranslatePageState> emit) {
    emit(state.copyWith(isLoading: true));
  }

  _onTranslateWordLocal(
      TranslateWordLocal event, Emitter<TranslatePageState> emit) async {
    if (event.word.trim().isEmpty) {
      emit(state.copyWith(
          isLoading: false, searchedVocabulary: [], isLocal: true));
      return;
    }
    emit(state.copyWith(isLoading: true));
    List<Vocabulary> result =
        await _translateRepository.translateLocal(event.word);

    emit(state.copyWith(
        isLoading: false, searchedVocabulary: result, isLocal: true));
  }

  _onLoadingSearch(LoadingSearch event, Emitter<TranslatePageState> emit) {
    emit(state.copyWith(isLoading: true));
  }

  __onTranslateWordRemote(
      TranslateWordRemote event, Emitter<TranslatePageState> emit) async {
    if (event.word.trim().isEmpty) {
      emit(state.copyWith(
          isLoading: false, searchedVocabulary: [], isLocal: false));
      return;
    }
    emit(state.copyWith(isLoading: true));
    // Vocabulary result =
    VocabularyRemote vocabularyRemote =
        await _translateRepository.translateWordOnline(event.word);
    emit(
      state.copyWith(
        isLoading: false,
        currentVocabularyRemote: vocabularyRemote,
        isLocal: false,
      ),
    );
  }
}

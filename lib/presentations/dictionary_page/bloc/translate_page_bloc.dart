import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:english_learner/models/vocabulary/vocab_translated_local.dart';
import 'package:english_learner/models/vocabulary/vocabulary.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/repository/translate_repository.dart';
import 'package:english_learner/services/vocab_translated_local_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'translate_page_event.dart';
part 'translate_page_state.dart';

class TranslatePageBloc extends Bloc<TranslateEvent, TranslatePageState> {
  final TranslateRepository _translateRepository = TranslateRepository();

  TranslatePageBloc() : super(TranslatePageState.initial()) {
    on<TranslateEventInitial>(_onTranslateEventInitial);
    on<TranslateWordEvent>(_onTranslateWord);
    on<TranslateWordLocal>(_onTranslateWordLocal);
    on<LoadingSearch>(_onLoadingSearch, transformer: droppable());
    on<TranslateWordRemote>(__onTranslateWordRemote);
  }

  _onTranslateEventInitial(
      TranslateEventInitial event, Emitter<TranslatePageState> emit) async {

    emit(state.copyWith(isLoading: true));
    ListVocabTranslated listVocabTranslatedVocab =
        await VocabTranslatedLocalServices().getListVocabTranslated();

    List<VocabTranslatedLocalModel> listFiltered = [];
    for (var item in listVocabTranslatedVocab.listVocabTranslated) {
      if (listFiltered.indexWhere((element) =>
              item.englishWords.word == element.englishWords.word) ==
          -1) {
        listFiltered.add(item);
      }
    }

    emit(
      state.copyWith(
        isLoading: false,
        listVocabTranslated: ListVocabTranslated(
          listVocabTranslated: listFiltered,
        ),
      ),
    );
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
      isLoading: false,
      searchedVocabulary: result,
      isLocal: true,
    ));
  }

  _onLoadingSearch(LoadingSearch event, Emitter<TranslatePageState> emit) {
    emit(state.copyWith(isLoading: true));
  }

  __onTranslateWordRemote(
      TranslateWordRemote event, Emitter<TranslatePageState> emit) async {
    if (event.word.trim() == "") {
      emit(state.copyWith(
          isLoading: false, searchedVocabulary: [], isLocal: false));
      return;
    }
    emit(state.copyWith(isLoading: true));
    // Vocabulary result =
    (VocabularyRemote, VocabularyRemote) vocabularyRemote =
        await _translateRepository.translateWordOnline(event.word);

    //Caching local
    await VocabTranslatedLocalServices()
        .insertVocabTranslated(VocabTranslatedLocalModel(
      englishWords: vocabularyRemote.$1,
      vietnameseWords: vocabularyRemote.$2,
    ));

    List<VocabTranslatedLocalModel> listVocabTranslatedVocab =
        List.from(state.listVocabTranslated.listVocabTranslated);

    listVocabTranslatedVocab.add(VocabTranslatedLocalModel(
      englishWords: vocabularyRemote.$1,
      vietnameseWords: vocabularyRemote.$2,
    ));
    emit(
      state.copyWith(
        isLoading: false,
        currentVocabularyRemote: vocabularyRemote,
        isLocal: false,
        listVocabTranslated: ListVocabTranslated(
          listVocabTranslated: listVocabTranslatedVocab,
        ),
      ),
    );
  }
}

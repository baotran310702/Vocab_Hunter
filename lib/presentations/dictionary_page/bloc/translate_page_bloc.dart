import 'package:english_learner/models/vocabulary.dart';
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
  }

  _onTranslateWord(TranslateWordEvent event, Emitter<TranslatePageState> emit) {
    emit(state.copyWith(isLoading: true));
  }

  _onTranslateWordLocal(
      TranslateWordLocal event, Emitter<TranslatePageState> emit) async {
    await _translateRepository.translateLocal(event.word);

    emit(state.copyWith(
        isLoading: false, currentVocabulary: Vocabulary.empty()));
  }
}

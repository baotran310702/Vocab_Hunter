import 'package:bloc/bloc.dart';
import 'package:english_learner/models/vocab_dto.dart';
import 'package:english_learner/models/vocabulary.dart';
import 'package:english_learner/services/vocab_services.dart';
import 'package:equatable/equatable.dart';

part 'manage_vocab_event.dart';
part 'manage_vocab_state.dart';

//Handle event to manage vocab

class ManageVocabBloc extends Bloc<ManageVocabEvent, ManageVocabState> {
  final VocabService _vocabService;

  ManageVocabBloc(this._vocabService) : super(ManageVocabState.initial()) {
    on<AddVocabEvent>(_onAddVocab);
    on<RemoveVocabEvent>(_onRemoveVocab);
    on<UpdateVocabEvent>(_onUpdateVocab);
    on<LoadVocabEvent>(_onLoadVocab);
    on<GetSimilarityVocabEvent>(_onGetSimilarityVocab);
    on<GetMeaningVocab>(_onGetMeaningVocab);
  }

  _onAddVocab(AddVocabEvent event, Emitter<ManageVocabState> emit) {
    emit(
        state.copyWith(vocabList: List.from(state.vocabList)..add(event.word)));
  }

  _onRemoveVocab(RemoveVocabEvent event, Emitter<ManageVocabState> emit) {
    List<Vocabulary> newVocabList = List.from(state.vocabList);
    newVocabList.removeWhere((element) => element.word == event.word);
    emit(state.copyWith(vocabList: newVocabList));
  }

  _onUpdateVocab(UpdateVocabEvent event, Emitter<ManageVocabState> emit) {
    int index = state.vocabList
        .indexWhere((element) => element.word == event.word.word);
    //update word in list with that index
    List<Vocabulary> newVocabList = List.from(state.vocabList);
    newVocabList[index] = event.word;

    emit(state.copyWith(vocabList: newVocabList));
  }

  _onLoadVocab(LoadVocabEvent event, Emitter<ManageVocabState> emit) async {}

  _onGetSimilarityVocab(
      GetSimilarityVocabEvent event, Emitter<ManageVocabState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<Vocab> similarVocabs =
        await _vocabService.getSimilarVocab(event.inputVocab);
    emit(state.copyWith(
      similarVocabs: similarVocabs,
      isLoading: false,
    ));
  }

  _onGetMeaningVocab(
      GetMeaningVocab event, Emitter<ManageVocabState> emit) async {
    emit(state.copyWith(isLoading: true));
    String meaning = await _vocabService.getTranslation(event.inputVocab);
    emit(state.copyWith(meaningRecommendVocabs: meaning, isLoading: false));
  }
}

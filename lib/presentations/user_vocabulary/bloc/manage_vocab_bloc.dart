import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:english_learner/models/vocabulary/vocabulary.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/repository/vocab_repository.dart';
import 'package:english_learner/services/translate_services.dart';
import 'package:equatable/equatable.dart';

import '../../../models/vocabulary/vocab_word_similarity.dart';

part 'manage_vocab_event.dart';
part 'manage_vocab_state.dart';

//Handle event to manage vocab

class ManageVocabBloc extends Bloc<ManageVocabEvent, ManageVocabState> {
  final VocabRepository _vocabRepository = VocabRepository();
  final TranslateServices _translateServices = TranslateServices();
  ManageVocabBloc() : super(ManageVocabState.initial()) {
    on<AddVocabEvent>(_onAddVocab);
    on<RemoveVocabEvent>(_onRemoveVocab);

    on<UpdateVocabEvent>(_onUpdateVocab);
    on<LoadVocabEvent>(_onLoadVocab);
    on<GetSimilarityVocabEvent>(_onGetSimilarityVocab);

    on<GetMeaningVocab>(_onGetMeaningVocab);
    on<GetSimilarityVocabLocalEvent>(_onGetSimilarityVocabLocal,
        transformer: droppable());
    on<GetSimilarVocabModel>(_onGetSimilarVocabModel);
  }

  _onAddVocab(AddVocabEvent event, Emitter<ManageVocabState> emit) {
    emit(
        state.copyWith(vocabList: List.from(state.vocabList)..add(event.word)));
  }

  _onRemoveVocab(RemoveVocabEvent event, Emitter<ManageVocabState> emit) {
    List<Vocabulary> newVocabList = List.from(state.vocabList);
    newVocabList.removeWhere((element) => element.vocabId == event.word);
    emit(state.copyWith(vocabList: newVocabList));
  }

  _onUpdateVocab(UpdateVocabEvent event, Emitter<ManageVocabState> emit) {
    int index = state.vocabList
        .indexWhere((element) => element.vocabId == event.word.vocabId);
    //update word in list with that index
    List<Vocabulary> newVocabList = List.from(state.vocabList);
    newVocabList[index] = event.word;

    emit(state.copyWith(vocabList: newVocabList));
  }

  _onLoadVocab(LoadVocabEvent event, Emitter<ManageVocabState> emit) async {}

  _onGetSimilarityVocab(
      GetSimilarityVocabEvent event, Emitter<ManageVocabState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<VocabWordSimilarity> similarVocabs =
        await _vocabRepository.getSimilarVocab(event.inputVocab);

    List<VocabWordSimilarity> highestSimilarity = List.generate(
        similarVocabs.length > 10 ? 10 : similarVocabs.length,
        (index) => similarVocabs[index]);

    var listTranslated = await Future.wait(highestSimilarity
        .map((e) => _translateServices.translateWordOnline(e.word)));

    emit(state.copyWith(
      similarVocabs: similarVocabs,
      isLoading: false,
      vocabRemoteList: listTranslated.map((e) => e).toList(),
    ));
  }

  _onGetSimilarityVocabLocal(GetSimilarityVocabLocalEvent event,
      Emitter<ManageVocabState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<VocabWordSimilarity> similarVocabs =
        await _vocabRepository.getSimilarVocabLocal(event.inputVocab);

    List<VocabWordSimilarity> highestSimilarity = List.generate(
        similarVocabs.length > 14 ? 14 : similarVocabs.length,
        (index) => similarVocabs[index]);

    var listTranslated = await Future.wait(highestSimilarity
        .map((e) => _translateServices.translateWordOnline(e.word)));

    emit(state.copyWith(
      similarVocabs: similarVocabs,
      isLoading: false,
      vocabRemoteList: listTranslated
          .where(
            (e) =>
                e.$1 != VocabularyRemote.empty() &&
                e.$2 != VocabularyRemote.empty() &&
                e.$1.meanings?.isNotEmpty == true,
          )
          .toList(),
    ));
  }

  _onGetMeaningVocab(
      GetMeaningVocab event, Emitter<ManageVocabState> emit) async {
    emit(state.copyWith(isLoading: true));
    String meaning = await _vocabRepository.getTranslation(event.inputVocab);
    emit(state.copyWith(meaningRecommendVocabs: meaning, isLoading: false));
  }

  _onGetSimilarVocabModel(
      GetSimilarVocabModel event, Emitter<ManageVocabState> emit) async {
    emit(state.copyWith(isLoading: true));
  }
}

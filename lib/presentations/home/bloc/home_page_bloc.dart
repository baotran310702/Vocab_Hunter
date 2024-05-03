import 'package:english_learner/models/news.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/models/vocabulary/vocab_word_similarity.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/repository/translate_repository.dart';
import 'package:english_learner/repository/vocab_repository.dart';
import 'package:english_learner/services/user_hive_local.dart';
import 'package:english_learner/services/user_pref_local.dart';
import 'package:english_learner/utils/cache_daily_vocab.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final VocabRepository _recommendsWords = VocabRepository();
  final TranslateRepository _translateRepository = TranslateRepository();
  HomePageBloc() : super(HomePageState.initial()) {
    on<HomePageInitialEvent>(_onInitial);
    on<CreateRecommendWords>(_onCreateRecommendWords);
  }

  _onInitial(HomePageInitialEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    var listInformation = await Future.wait([
      UserHiveLocal().getUser(),
      UserPrefererencesLocal().getDefaultListLearningVocab()
    ]);

    //init cache instance to get daily vocab
    var currentVocabGlobal = GlobalDailyVocab();

    List<(VocabularyRemote, VocabularyRemote)> currentRecommendWords =
        currentVocabGlobal.getDailyVocab();

    if (currentRecommendWords.isNotEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          currentRecommendWords: currentRecommendWords,
        ),
      );
      return;
    }

    UserModel user = listInformation[0] as UserModel;
    String defaultIdVocabList = listInformation[1] as String;

    UserVocab currentDefaultUserVocab =
        user.learningWords.firstWhere((element) {
      return element.listId == defaultIdVocabList;
    });

    List<String> currentStringWords = currentDefaultUserVocab
        .listVocabulary.entries.first.value
        .map((e) => e.word ?? "")
        .toList();

    List<VocabWordSimilarity> recommendsWords = await _recommendsWords
        .getWordsSimmilarityFromListLocal(currentStringWords);

    var listTranslated = await Future.wait(recommendsWords.map((e) async {
      return await _translateRepository.translateWordOnline(e.word);
    }).toList());

    List<(VocabularyRemote, VocabularyRemote)> currentVocabRemotesTranslated =
        [];

    for (int i = 0; i < recommendsWords.length; i++) {
      currentVocabRemotesTranslated.add((listTranslated[i]));
    }

    //update to cache
    currentVocabGlobal.setDailyVocab(currentVocabRemotesTranslated);

    emit(
      state.copyWith(
        isLoading: false,
        currentUser: user,
        currentRecommendWords: currentVocabRemotesTranslated,
      ),
    );
  }

  _onCreateRecommendWords(CreateRecommendWords event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    List<VocabWordSimilarity> recommendsWords =
        await _recommendsWords.getSimilarVocab(event.word);

    emit(state.copyWith(recommendVocabs: recommendsWords, isLoading: false));
  }
}

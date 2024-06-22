import 'package:english_learner/models/news.dart';
import 'package:english_learner/models/sub_topic.dart';
import 'package:english_learner/models/topic.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/models/vocabulary/vocab_word_similarity.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/models/vocabulary_topic/list_vocabulary_topic.dart';
import 'package:english_learner/repository/news_repository.dart';
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
  final VocabRepository _vocabRepository = VocabRepository();
  final TranslateRepository _translateRepository = TranslateRepository();
  final NewsRepository _newsRepository = NewsRepository();
  HomePageBloc() : super(HomePageState.initial()) {
    on<HomePageInitialEvent>(_onInitial);
    on<CreateRecommendWords>(_onCreateRecommendWords);
    on<InitTopicVocabulary>(_onInitTopicVocabulary);
    on<InitDetailTopicVocabulary>(_onInitDetailTopicVocabulary);
    on<DownLoadDetailTopicVocab>(_onDownLoadDetailTopicVocab);
    on<ChangeLoveSubTopicStatus>(_onChangeLoveSubTopicStatus);
  }

  _onChangeLoveSubTopicStatus(
      ChangeLoveSubTopicStatus event, Emitter emit) async {
    emit(
      state.copyWith(isLoading: true),
    );

    List<SubTopic> listSubTopic =
        List.from(await _vocabRepository.getFavouriteTopic());

    if (listSubTopic.indexWhere((element) =>
            element.name.trim().toLowerCase() ==
            event.subTopic.name.trim().toLowerCase()) !=
        -1) {
      listSubTopic.removeWhere((element) =>
          element.name.trim().toLowerCase() ==
          event.subTopic.name.trim().toLowerCase());
    } else {
      listSubTopic.add(event.subTopic.copyWith(isLiked: true));
    }

    await _vocabRepository.updateListFavouriteTopic(listSubTopic);

    emit(state.copyWith(
      isLoading: false,
      listSubTopicFavouriteLocal: listSubTopic,
    ));
  }

  _onDownLoadDetailTopicVocab(
      DownLoadDetailTopicVocab event, Emitter emit) async {
    ListVocabularyTopic vocabularyTopic =
        await _vocabRepository.getOneListTopicVocabularyTopic(
      topicId: event.topicId,
      subTopicId: event.subTopicId,
    );
    List<SubTopic> listSubTopicFavouriteLocal =
        await _vocabRepository.getFavouriteTopic();

    await _vocabRepository.saveAListVocabularyTopicLocal(vocabularyTopic);
    if (state is DetailVocabTopicState) {
      final currentState = state as DetailVocabTopicState;
      final updatedListSubTopicItemLocal =
          List<ListVocabularyTopic>.from(currentState.listSubTopicItemLocal)
            ..add(vocabularyTopic);

      emit(DetailVocabTopicState(
        isLoading: state.isLoading,
        news: state.news,
        recommendVocabs: state.recommendVocabs,
        currentUser: state.currentUser,
        listTopicVocab: state.listTopicVocab,
        listSubTopicItemLocal: updatedListSubTopicItemLocal,
        listSubTopicFavouriteLocal: listSubTopicFavouriteLocal,
      ));
    }
  }

  _onInitDetailTopicVocabulary(
      InitDetailTopicVocabulary event, Emitter emit) async {
    List<ListVocabularyTopic> listVocabTopicLocal =
        await _vocabRepository.getListVocabTopicsLocal();
    List<SubTopic> listSubTopic = await _vocabRepository.getFavouriteTopic();
    emit(
      DetailVocabTopicState(
        isLoading: state.isLoading,
        news: state.news,
        recommendVocabs: state.recommendVocabs,
        currentUser: state.currentUser,
        listTopicVocab: state.listTopicVocab,
        listSubTopicItemLocal: listVocabTopicLocal,
        listSubTopicFavouriteLocal: listSubTopic,
      ),
    );
  }

  _onInitTopicVocabulary(InitTopicVocabulary event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    List<Topic> listTopicLocal = await _vocabRepository.getListTopicCaching();

    if (listTopicLocal.isEmpty) {
      List<Topic> listTopicVocab = await _vocabRepository.getAllTopicVocab();
      await _vocabRepository.saveListTopicLocal(listTopicVocab);
      emit(state.copyWith(isLoading: false, listTopicVocab: listTopicVocab));
      return;
    }

    emit(state.copyWith(isLoading: false, listTopicVocab: listTopicLocal));
  }

  _onInitial(HomePageInitialEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    var listInformation = await Future.wait([
      UserHiveLocal().getUser(),
      UserPrefererencesLocal().getDefaultListLearningVocab(),
    ]);

    List<News> news = News.defaultNews;

    //init cache instance to get daily vocab
    var currentVocabGlobal = GlobalDailyVocab();

    List<(VocabularyRemote, VocabularyRemote)> currentRecommendWords =
        currentVocabGlobal.getDailyVocab();

    if (currentRecommendWords.isNotEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          currentRecommendWords: currentRecommendWords,
          news: news,
        ),
      );
      return;
    } else {
      emit(state.copyWith(news: news));
    }

    UserModel user = listInformation[0] as UserModel;
    String defaultIdVocabList = listInformation[1] as String;

    UserVocab currentDefaultUserVocab = defaultIdVocabList.trim() != ""
        ? user.learningWords.firstWhere((element) {
            return element.listId == defaultIdVocabList;
          })
        : user.learningWords[0];

    List<String> currentStringWords = currentDefaultUserVocab
        .listVocabulary.entries.first.value
        .map((e) => e.word ?? "")
        .toList();

    List<VocabWordSimilarity> recommendsWords = await _vocabRepository
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
        news: news,
      ),
    );
  }

  _onCreateRecommendWords(CreateRecommendWords event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    List<VocabWordSimilarity> recommendsWords =
        await _vocabRepository.getSimilarVocab(event.word);

    emit(state.copyWith(recommendVocabs: recommendsWords, isLoading: false));
  }
}

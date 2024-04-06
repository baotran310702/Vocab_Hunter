import 'package:english_learner/models/news.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/models/vocabulary/vocab_word_similarity.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/repository/vocab_repository.dart';
import 'package:english_learner/services/user_hive_local.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final VocabRepository _recommendsWords = VocabRepository();
  HomePageBloc() : super(HomePageState.initial()) {
    on<HomePageInitialEvent>(_onInitial);
    on<CreateRecommendWords>(_onCreateRecommendWords);
  }

  _onInitial(HomePageInitialEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    UserModel user = await UserHiveLocal().getUser();
    emit(
      state.copyWith(isLoading: false, currentUser: user),
    );
  }

  _onCreateRecommendWords(CreateRecommendWords event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    List<VocabWordSimilarity> recommendsWords =
        await _recommendsWords.getSimilarVocab(event.word);

    emit(state.copyWith(recommendVocabs: recommendsWords, isLoading: false));
  }
}

part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  final bool isLoading;
  final List<News> news;
  final List<VocabWordSimilarity> recommendVocabs;
  final UserModel currentUser;
  final List<(VocabularyRemote, VocabularyRemote)>? currentRecommendWords;
  final List<Topic> listTopicVocab;

  const HomePageState({
    required this.isLoading,
    required this.news,
    required this.recommendVocabs,
    required this.currentUser,
    this.currentRecommendWords,
    required this.listTopicVocab,
  });

  factory HomePageState.initial() {
    return HomePageState(
      isLoading: false,
      news: const [],
      recommendVocabs: const [],
      currentUser: UserModel.empty(),
      currentRecommendWords: null,
      listTopicVocab: const [],
    );
  }

  HomePageState copyWith({
    bool? isLoading,
    List<News>? news,
    List<VocabWordSimilarity>? recommendVocabs,
    UserModel? currentUser,
    List<(VocabularyRemote, VocabularyRemote)>? currentRecommendWords,
    List<Topic>? listTopicVocab,
    List<SubTopic>? listSubTopicFavouriteLocal,
  }) {
    return HomePageState(
      isLoading: isLoading ?? this.isLoading,
      news: news ?? this.news,
      recommendVocabs: recommendVocabs ?? this.recommendVocabs,
      currentUser: currentUser ?? this.currentUser,
      currentRecommendWords: currentRecommendWords,
      listTopicVocab: listTopicVocab ?? this.listTopicVocab,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        news,
        recommendVocabs,
        currentUser,
        listTopicVocab,
      ];
}

class DetailVocabTopicState extends HomePageState {
  final List<ListVocabularyTopic> listSubTopicItemLocal;
  final List<SubTopic>? listSubTopicFavouriteLocal;
  const DetailVocabTopicState({
    required super.isLoading,
    required super.news,
    required super.recommendVocabs,
    required super.currentUser,
    required super.listTopicVocab,
    required this.listSubTopicItemLocal,
    this.listSubTopicFavouriteLocal,
  });

  //factory empty initstate

  factory DetailVocabTopicState.initialState() {
    return DetailVocabTopicState(
      isLoading: false,
      news: const [],
      recommendVocabs: const [],
      currentUser: UserModel.empty(),
      listTopicVocab: const [],
      listSubTopicItemLocal: const [],
      listSubTopicFavouriteLocal: const [],
    );
  }

  @override
  DetailVocabTopicState copyWith({
    bool? isLoading,
    List<News>? news,
    List<VocabWordSimilarity>? recommendVocabs,
    UserModel? currentUser,
    List<(VocabularyRemote, VocabularyRemote)>? currentRecommendWords,
    List<Topic>? listTopicVocab,
    List<ListVocabularyTopic>? listSubTopicItemLocal,
    List<SubTopic>? listSubTopicFavouriteLocal,
  }) {
    return DetailVocabTopicState(
      isLoading: isLoading ?? this.isLoading,
      news: news ?? this.news,
      recommendVocabs: recommendVocabs ?? this.recommendVocabs,
      currentUser: currentUser ?? this.currentUser,
      listTopicVocab: listTopicVocab ?? this.listTopicVocab,
      listSubTopicItemLocal:
          listSubTopicItemLocal ?? this.listSubTopicItemLocal,
      listSubTopicFavouriteLocal:
          listSubTopicFavouriteLocal ?? this.listSubTopicFavouriteLocal,
    );
  }

  @override
  List<Object?> get props => super.props..addAll([listSubTopicItemLocal]);
}

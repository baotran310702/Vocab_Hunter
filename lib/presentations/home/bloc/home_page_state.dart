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

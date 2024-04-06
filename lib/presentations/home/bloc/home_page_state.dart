part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  final bool isLoading;
  final List<News> news;
  final List<VocabWordSimilarity> recommendVocabs;
  final UserModel currentUser;
  final List<VocabularyRemote>? currentRecommendWords;

  const HomePageState({
    required this.isLoading,
    required this.news,
    required this.recommendVocabs,
    required this.currentUser,
    this.currentRecommendWords,
  });

  factory HomePageState.initial() {
    return HomePageState(
      isLoading: false,
      news: const [],
      recommendVocabs: const [],
      currentUser: UserModel.empty(),
      currentRecommendWords: null,
    );
  }

  HomePageState copyWith({
    bool? isLoading,
    List<News>? news,
    List<VocabWordSimilarity>? recommendVocabs,
    UserModel? currentUser,
    List<VocabularyRemote>? currentRecommendWords,
  }) {
    return HomePageState(
      isLoading: isLoading ?? this.isLoading,
      news: news ?? this.news,
      recommendVocabs: recommendVocabs ?? this.recommendVocabs,
      currentUser: currentUser ?? this.currentUser,
      currentRecommendWords: currentRecommendWords,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        news,
        recommendVocabs,
        currentUser,
      ];
}

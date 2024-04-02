part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  final bool isLoading;
  final List<News> news;
  final List<VocabDTO> recommendVocabs;
  final UserModel currentUser;

  const HomePageState({
    required this.isLoading,
    required this.news,
    required this.recommendVocabs,
    required this.currentUser,
  });

  factory HomePageState.initial() {
    return HomePageState(
      isLoading: false,
      news: const [],
      recommendVocabs: const [],
      currentUser: UserModel.empty(),
    );
  }

  HomePageState copyWith({
    bool? isLoading,
    List<News>? news,
    List<VocabDTO>? recommendVocabs,
    UserModel? currentUser,
  }) {
    return HomePageState(
      isLoading: isLoading ?? this.isLoading,
      news: news ?? this.news,
      recommendVocabs: recommendVocabs ?? this.recommendVocabs,
      currentUser: currentUser ?? this.currentUser,
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

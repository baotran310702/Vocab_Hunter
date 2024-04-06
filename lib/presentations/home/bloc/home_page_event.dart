part of 'home_page_bloc.dart';

abstract class HomePageEvent {}

class HomePageInitialEvent extends HomePageEvent {}

class CreateRecommendWords extends HomePageEvent {
  final String word;
  CreateRecommendWords({required this.word});
}

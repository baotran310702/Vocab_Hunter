part of 'translate_page_bloc.dart';

abstract class TranslateEvent {}

class TranslateEventInitial extends TranslateEvent {}

class TranslateWordEvent extends TranslateEvent {
  final String word;
  TranslateWordEvent(this.word);
}

class TranslateSentenceEvent extends TranslateEvent {
  final String sentence;
  TranslateSentenceEvent(this.sentence);
}

class TranslateWordLocal extends TranslateEvent {
  final String word;
  TranslateWordLocal(this.word);
}

class TranslateWordRemote extends TranslateEvent {
  final String word;
  TranslateWordRemote({required this.word});
}

class LoadingSearch extends TranslateEvent {}

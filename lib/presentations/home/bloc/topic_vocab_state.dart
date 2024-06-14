part of 'topic_vocab_bloc.dart';

class TopicVocabularyState extends Equatable {
  final bool isLoading;

  final SubTopic currentSubTopic;

  final List<VocabTopic> listVocabulary;

  const TopicVocabularyState({
    required this.isLoading,
    required this.currentSubTopic,
    required this.listVocabulary,
  });

  factory TopicVocabularyState.initial() {
    return TopicVocabularyState(
      isLoading: false,
      currentSubTopic: SubTopic.initial(),
      listVocabulary: const [],
    );
  }

  //copywith
  TopicVocabularyState copyWith({
    bool? isLoading,
    SubTopic? currentSubTopic,
    List<VocabTopic>? listVocabulary,
  }) {
    return TopicVocabularyState(
      isLoading: isLoading ?? this.isLoading,
      currentSubTopic: currentSubTopic ?? this.currentSubTopic,
      listVocabulary: listVocabulary ?? this.listVocabulary,
    );
  }

  @override
  List<Object?> get props => [isLoading, currentSubTopic, listVocabulary];
}

import 'dart:math';

import 'package:english_learner/models/sub_topic.dart';
import 'package:english_learner/models/vocabulary/vocab_topic.dart';
import 'package:english_learner/repository/vocab_repository.dart';
import 'package:english_learner/utils/cache_topic_choosen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/vocabulary_topic/list_vocabulary_topic.dart';

part 'topic_vocab_event.dart';
part 'topic_vocab_state.dart';

class TopicVocabularyBloc extends Bloc<TopicVocabEvent, TopicVocabularyState> {
  final VocabRepository _vocabRepository = VocabRepository();
  TopicVocabularyBloc() : super(TopicVocabularyState.initial()) {
    on<GetVocabTopicEvent>(_onGetVocabTopic);
  }

  _onGetVocabTopic(GetVocabTopicEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    CacheTopicChoosen topicCache = CacheTopicChoosen();
    String topicId = topicCache.getTopicId();
    String subTopicId = event.subTopic.subTopicId;

    List<ListVocabularyTopic> listVocabTopic =
        await _vocabRepository.getListVocabTopicsLocal();

    ListVocabularyTopic listVocabTopicByTopic = listVocabTopic.firstWhere(
      (element) =>
          element.topic.trim().toLowerCase() == subTopicId.trim().toLowerCase(),
    );

    emit(
      state.copyWith(
        isLoading: false,
        currentSubTopic: event.subTopic,
        listVocabulary: listVocabTopicByTopic.vocabularyByTopic,
      ),
    );
  }
}

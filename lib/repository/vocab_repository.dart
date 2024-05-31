import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learner/models/topic.dart';
import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/models/vocabulary/vocab_word_similarity.dart';
import 'package:english_learner/models/vocabulary/vocabulary.dart';
import 'package:english_learner/models/vocabulary_topic/list_vocabulary_topic.dart';
import 'package:english_learner/services/recommend_words.dart';
import 'package:english_learner/services/topic_vocab_service.dart';
import 'package:english_learner/services/vocab_services.dart';
import 'package:english_learner/utils/firebase_collections.dart';

import '../models/user.dart';

class VocabRepository {
  late VocabService vocabService;
  late RecommendsWords recommendsWords;
  late TopicVocabServices topicVocabServices;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  VocabRepository() {
    vocabService = VocabService();
    recommendsWords = RecommendsWords();
    topicVocabServices = TopicVocabServices();
  }

  Future<List<VocabWordSimilarity>> getSimilarVocab(String word) async {
    return await recommendsWords.getWordsFromWordSimilarity(word);
  }

  Future<List<VocabWordSimilarity>> getSimilarVocabLocal(String word) async {
    return await recommendsWords.getWordsFromWordSimilarityLocal(word);
  }

  Future<String> getTranslation(String inputWord) async {
    return await vocabService.getTranslation(inputWord);
  }

  Future<List<Vocabulary>> getVocabularies() async {
    List<Vocabulary> listVocabularies = [];
    final ref = await firestore.collection(AppCollections.vocabulary).get();
    for (var doc in ref.docs) {
      listVocabularies.add(Vocabulary.fromFirebase(doc.data()));
    }
    return listVocabularies;
  }

  Future<List<Vocabulary>> getUserLearningVocabs(UserModel user) async {
    List<UserVocab> usersVocabs = user.learnedWords;
    List<Vocabulary> listVocabs = await getVocabularies();
    List<Vocabulary> userLearningVocabs = listVocabs
        .where(
            (element) => usersVocabs.any((e) => e.listName == element.vocabId))
        .toList();
    return userLearningVocabs;
  }

  Future<List<VocabWordSimilarity>> getWordsSimmilarityFromListLocal(
      List<String> words) async {
    return await recommendsWords.getWordsSimmilarityFromListLocal(words);
  }

  Future<List<Topic>> getAllTopicVocab() async {
    return await topicVocabServices.getAllTopicVocab();
  }

  Future<List<ListVocabularyTopic>> getListVocabTopicsLocal() async {
    return await topicVocabServices.getListVocabTopicLocal();
  }

  Future<ListVocabularyTopic> getOneListTopicVocabularyTopic(
      {required String topicId, required String subTopicId}) async {
    return await topicVocabServices.getOneListTopicVocabularyTopic(
        topicId, subTopicId);
  }

  Future<void> saveListVocabularyTopicLocal(
      List<ListVocabularyTopic> listVocabularyTopic) async {
    await topicVocabServices.saveListVocabularyTopicLocal(listVocabularyTopic);
  }

  Future<void> saveAListVocabularyTopicLocal(
      ListVocabularyTopic listVocabulary) async {
    await topicVocabServices.saveAListVocabularyTopicLocal(listVocabulary);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learner/models/sub_topic.dart';
import 'package:english_learner/models/topic.dart';
import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/models/vocabulary/vocab_word_similarity.dart';
import 'package:english_learner/models/vocabulary/vocabulary.dart';
import 'package:english_learner/models/vocabulary_topic/list_vocabulary_topic.dart';
import 'package:english_learner/services/favourite_topic_services.dart';
import 'package:english_learner/services/recommend_words.dart';
import 'package:english_learner/services/topic_vocab_service.dart';
import 'package:english_learner/services/vocab_services.dart';
import 'package:english_learner/utils/firebase_collections.dart';

import '../models/user.dart';

class VocabRepository {
  late VocabService vocabService;
  late RecommendsWords recommendsWords;
  late TopicVocabServices topicVocabServices;
  late FavouriteTopicLocal favouriteTopicLocal;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  VocabRepository() {
    vocabService = VocabService();
    recommendsWords = RecommendsWords();
    topicVocabServices = TopicVocabServices();
    favouriteTopicLocal = FavouriteTopicLocal();
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

  ///For local storage
  /// Get all list of vocabulary topic from local storage
  Future<List<ListVocabularyTopic>> getListVocabTopicsLocal() async {
    return await topicVocabServices.getListVocabTopicLocal();
  }

  ///For local storage
  /// Get a list of vocabulary topic remotely from firebase
  Future<ListVocabularyTopic> getOneListTopicVocabularyTopic(
      {required String topicId, required String subTopicId}) async {
    return await topicVocabServices.getOneListTopicVocabularyTopic(
        topicId, subTopicId);
  }

  ///For local storage
  /// Get a list of vocabulary topic from local storage
  Future<ListVocabularyTopic> getOneListTopicVocabularyTopicLocal(
      {required String subTopicId}) async {
    return await topicVocabServices
        .getOneListTopicVocabularyTopicLocal(subTopicId);
  }

  ///For local storage
  /// Save a list of vocabulary topic to local storage
  Future<void> saveListVocabularyTopicLocal(
      List<ListVocabularyTopic> listVocabularyTopic) async {
    await topicVocabServices.saveListVocabularyTopicLocal(listVocabularyTopic);
  }

  ///For local storage
  /// Save a list of vocabulary topic to local storage
  Future<void> saveAListVocabularyTopicLocal(
      ListVocabularyTopic listVocabulary) async {
    await topicVocabServices.saveAListVocabularyTopicLocal(listVocabulary);
  }

  ///For local storage
  /// Get all list of topic from local storage
  Future<List<Topic>> getListTopicCaching() async {
    return await topicVocabServices.getListTopicCaching();
  }

  ///For local storage
  /// Save a list of topic to local storage
  Future<void> saveListTopicLocal(List<Topic> listTopic) async {
    await topicVocabServices.saveListTopicLocal(listTopic);
  }

  ///For favourite local storage
  ///Add a subtopic to favourite hive local in [FavouriteTopicServices]
  Future<void> addSubTopicFavourite(SubTopic subTopic) async {
    await favouriteTopicLocal.addFavouriteTopic(subTopic);
  }

  ///For favourite local storage
  ///Remove a subtopic from hive local
  Future<List<SubTopic>> getFavouriteTopic() async {
    return await favouriteTopicLocal.getFavouriteTopic();
  }

  ///For favourite local storage
  Future<void> updateListFavouriteTopic(List<SubTopic> newListSubTopic) async {
    await favouriteTopicLocal.updateListFavouriteTopic(newListSubTopic);
  }
}

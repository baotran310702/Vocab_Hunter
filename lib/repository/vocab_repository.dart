import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/models/vocabulary/vocab_word_similarity.dart';
import 'package:english_learner/models/vocabulary/vocabulary.dart';
import 'package:english_learner/services/recommend_words.dart';
import 'package:english_learner/services/vocab_services.dart';
import 'package:english_learner/utils/firebase_collections.dart';

import '../models/user.dart';

class VocabRepository {
  late VocabService vocabService;
  late RecommendsWords recommendsWords;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  VocabRepository() {
    vocabService = VocabService();
    recommendsWords = RecommendsWords();
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
}

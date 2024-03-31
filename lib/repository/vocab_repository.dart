import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learner/models/vocabulary/vocab_dto.dart';
import 'package:english_learner/models/vocabulary/vocabulary.dart';
import 'package:english_learner/services/vocab_services.dart';
import 'package:english_learner/utils/firebase_collections.dart';

import '../models/user.dart';

class VocabRepository {
  late VocabService vocabService;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  VocabRepository() {
    vocabService = VocabService();
  }

  Future<List<VocabDTO>> getSimilarVocab(String word) async {
    return await vocabService.getSimilarVocab(word);
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
    List<String> usersVocabs = user.learnedWords;
    List<Vocabulary> listVocabs = await getVocabularies();
    List<Vocabulary> userLearningVocabs = listVocabs
        .where((element) => usersVocabs.any((e) => e == element.vocabId))
        .toList();
    return userLearningVocabs;
  }
}

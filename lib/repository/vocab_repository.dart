import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learner/models/vocab_dto.dart';
import 'package:english_learner/models/vocabulary.dart';
import 'package:english_learner/services/vocab_services.dart';
import 'package:english_learner/utils/collections.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/user.dart';

class VocabRepository {
  late VocabService vocabService;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  VocabRepository() {
    vocabService = VocabService();
  }

  Future<List<Vocab>> getSimilarVocab(String word) async {
    return await vocabService.getSimilarVocab(word);
  }

  Future<String> getTranslation(String inputWord) async {
    return await vocabService.getTranslation(inputWord);
  }

  Future<List<Vocabulary>> getVocabularies() async{
    List<Vocabulary> listVocabularies = [];
    final ref = await firestore.collection(AppCollections.vocabulary).get();
    for (var doc in ref.docs){
      listVocabularies.add(Vocabulary.fromJson(doc.data()));
    }
    return listVocabularies;
  }

  Future<List<Vocabulary>> getUserLearningVocabs(User user) async{
    List<String> usersVocabs = user.learnedWords;
    List<Vocabulary> listVocabs = await getVocabularies();
    List<Vocabulary> userLearningVocabs = listVocabs.where((element) =>usersVocabs.any((e) => e == element.vocabId)).toList();
    return userLearningVocabs;
  }

  
}

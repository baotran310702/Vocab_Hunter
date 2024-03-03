import 'package:english_learner/models/vocab_dto.dart';
import 'package:english_learner/services/vocab_services.dart';

class VocabRepository {
  late VocabService vocabService;

  VocabRepository() {
    vocabService = VocabService();
  }

  Future<List<Vocab>> getSimilarVocab(String word) async {
    return await vocabService.getSimilarVocab(word);
  }

  Future<String> getTranslation(String inputWord) async {
    return await vocabService.getTranslation(inputWord);
  }
}

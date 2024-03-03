import 'package:english_learner/models/vocab_dto.dart';
import 'package:english_learner/services/vocab_services.dart';

class AppService{
  VocabService vocabService = VocabService();

   Future<List<Vocab>> getSimilarVocab(String word) async {
    return await vocabService.getSimilarVocab(word);
   }
}
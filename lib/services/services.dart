import 'package:english_learner/models/vocabulary.dart';
import 'package:english_learner/repository/vocab_repository.dart';

class AppServices {
  late AppServices _services;

  VocabRepository vocabRepository = VocabRepository();

  //init constructor
  AppServices() {
    _services = AppServices();
  }

  Future<List<Vocabulary>> getSimilarVocab(String word) async {
    return await vocabRepository.getSimilarVocab(word);
  }
}

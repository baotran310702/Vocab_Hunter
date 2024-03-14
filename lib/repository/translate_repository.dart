import 'package:english_learner/models/vocabulary.dart';
import 'package:english_learner/services/translate_services.dart';

class TranslateRepository {
  late TranslateServices _services;

  TranslateRepository() {
    _services = TranslateServices();
  }

  Future<List<Vocabulary>> translateLocal(String word) async {
    return await _services.translateLocal(word);
  }
}

import 'package:english_learner/services/translate_services.dart';

class TranslateRepository {
  late TranslateServices _services;

  TranslateRepository() {
    _services = TranslateServices();
  }

  Future<void> translateLocal(String word) async {
    await _services.translateLocal(word);
  }
}

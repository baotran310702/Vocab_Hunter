import 'package:english_learner/services/gemini_services.dart';

class GeminiRepository {
  final GeminiServices geminiServices = GeminiServices();

  Future<String> getExampleSentencesVocab(String word) async {
    return await geminiServices.getExampleSentencesVocab(word);
  }
}

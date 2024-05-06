import 'package:english_learner/utils/constants.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiServices {
  GeminiServices._();

  static final GeminiServices instance = GeminiServices._();

  final geminiClient = Gemini.init(apiKey: APIKeys.geminiAPIKey);

  factory GeminiServices() {
    return instance;
  }

  Future<String> getExampleSentencesVocab(String word) async {
    final instanceGemini = GeminiServices.instance;

    final response = await instanceGemini.geminiClient
        .text(
            "Give me an example for word '$word', the example must contain exactly the word '$word' and just give me only one sentences.")
        .then((value) => value?.output ?? "No result found!")
        .catchError((e) => e.toString());
    return response.toString();
  }
}

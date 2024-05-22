import 'package:english_learner/utils/constants.dart';
import 'package:flutter/material.dart';
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

    int time = 0;
    int maxTry = 3;

    while (time < maxTry) {
      try {
        final response = await instanceGemini.geminiClient.text(
            "Give me an example for word '$word', the example must contain exactly the word '$word' and just give me only one sentences.");

        String result = response?.content?.parts?.last.text ?? "";
        if (result != "") {
          return result;
        } else {
          time++;
        }
      } catch (e) {
        debugPrint("Error Gemini: $e");
      }
    }
    return "";
  }

  Future<String> getDescriptionTopic(String word) async {
    final instanceGemini = GeminiServices.instance;

    int time = 0;
    int maxTry = 3;

    while (time < maxTry) {
      try {
        final response = await instanceGemini.geminiClient.text(
            "Give me a description for topic '$word', the description must contain the word '$word' and just give me only one sentences and less than 10 words.");

        String result = response?.content?.parts?.last.text ?? "";
        if (result != "") {
          return result;
        } else {
          time++;
        }
      } catch (e) {
        debugPrint("Error Gemini: $e");
      }
    }
    return "";
  }
}

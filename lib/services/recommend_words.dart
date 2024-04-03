import 'package:dio/dio.dart';
import 'package:english_learner/models/vocabulary/vocab_word_similarity.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:flutter/material.dart';

class RecommendsWords {
  late RecommendsWords recommendsWords;

  void init() {
    recommendsWords = RecommendsWords();
  }

  Future<List<VocabWordSimilarity>> getWordsFromWordSimilarity(
      String word) async {
    List<VocabWordSimilarity> result = [];
    try {
      var apiURL = APIPath.wordSimilarity + word;
      var response = await Dio().get(apiURL);

      if (response.statusCode == 200) {
        //parse response to list of vocab
        var data = response.data;
        for (var value in data) {
          result.add(VocabWordSimilarity.fromJson(value));
        }
      }
    } catch (e) {
      debugPrint(Exception(e).toString());
      return result;
    }
    return result;
  }
}

import 'package:dio/dio.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../models/vocabulary/vocab_dto.dart';

class VocabService {
  //fetch translation from api
  Future<String> getTranslation(String inputWord) async {
    final translator = GoogleTranslator();
    try {
      //fetch api using http
      var translatorResult = await translator.translate(
        inputWord,
        to: 'vi',
      );
      return translatorResult.text;
    } catch (e) {
      debugPrint(Exception(e).toString());
    }

    return "Can't translate";
  }

  //fetch similar vocab from api
  Future<List<VocabDTO>> getSimilarVocab(String word) async {
    List<VocabDTO> vocabList = [];
    try {
      //fetch api using http
      var apiURL = APIPath.wordSimilarity + word;
      var response = await Dio().get(apiURL);

      //check if reponse
      if (response.statusCode == 200) {
        //parse response to list of vocab
        var data = response.data;
        for (var i = 0; i < data.length; i++) {
          VocabDTO vocab = VocabDTO.fromJson(data[i]);
          vocabList.add(vocab);
        }
      }
    } catch (e) {
      debugPrint(Exception(e).toString());
    }

    return vocabList;
  }
}

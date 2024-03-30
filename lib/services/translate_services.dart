import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:english_learner/models/vocabulary/vocabulary.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';

import 'package:english_learner/utils/constants_api.dart';
import 'package:english_learner/utils/extension.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';

class TranslateServices {
  late String jsonString;

  late GoogleTranslator translator;

  TranslateServices() {
    _init();
  }

  void _init() async {
    jsonString = await rootBundle.loadString('assets/dictionary.json');
    translator = GoogleTranslator();
  }

  Future<List<Vocabulary>> translateLocal(String word) async {
    var jsonResult = json.decode(jsonString) as List;
    List<Vocabulary> vocabList = [];

    List<dynamic> result = jsonResult;

    for (var item in result) {
      String itemString = item[1][0].toString();
      if (itemString == word || itemString.isStartWith(word)) {
        vocabList.add(Vocabulary.fromLocal(item));
        if (vocabList.length > 15) {
          return vocabList;
        }
      }
    }

    return vocabList;
  }

  //params contain both eng - vi
  Future<(VocabularyRemote, VocabularyRemote)> translateWordOnline(
      String value) async {
    String word = value.trim();
    final response = await Dio().get("${APIPath.dictionaryDev}$word");
    if (response.statusCode == 200) {
      final data = response.data;
      VocabularyRemote englishVocabMeaning = VocabularyRemote.fromJson(data[0]);

      VocabularyRemote vietnamVocabMeaning =
          await englishVocabMeaning.toVietnamese();

      return (englishVocabMeaning, vietnamVocabMeaning);
    } else {
      return (VocabularyRemote.empty(), VocabularyRemote.empty());
    }
  }

  Future<String> translatePerWordRemote(String word) async {
    final translator = GoogleTranslator();
    final translation = await translator.translate(word, from: 'en', to: 'vi');
    return translation.text;
  }
}

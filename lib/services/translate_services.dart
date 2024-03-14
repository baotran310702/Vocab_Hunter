import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:english_learner/models/vocabulary/vocabulary.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';

import 'package:english_learner/utils/constants.dart';
import 'package:english_learner/utils/extension.dart';
import 'package:flutter/services.dart';

class TranslateServices {
  late String jsonString;

  TranslateServices() {
    _init();
  }

  void _init() async {
    jsonString = await rootBundle.loadString('assets/dictionary.json');
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

  Future<VocabularyRemote> translateWordOnline(String word) async {
    final response = await Dio().get("${APIPath.dictionaryDev}$word");
    if (response.statusCode == 200) {
      final data = response.data;
      return VocabularyRemote.fromJson(data[0]);
    } else {
      return VocabularyRemote.empty();
    }
  }
}

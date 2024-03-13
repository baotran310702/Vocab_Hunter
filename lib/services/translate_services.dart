import 'dart:convert';

import 'package:english_learner/models/vocabulary.dart';
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
      String itemString = item[1].toString();
      if (itemString.contains(word)) {
        vocabList.add(Vocabulary.fromLocal(item));
        if (vocabList.length > 15) {
          return vocabList;
        }
      }
    }

    return vocabList;
  }
}

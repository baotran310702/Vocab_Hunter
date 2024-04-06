import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

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
}

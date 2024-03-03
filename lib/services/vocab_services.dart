import 'package:dio/dio.dart';
import 'package:english_learner/models/vocab_dto.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:translator/translator.dart';

class VocabService {
  //fetch translation from api
  Future<String> getTranslation(String inputWord) async {
    final translator = GoogleTranslator();
    try {
      //fetch api using http
      var translatorResult = await translator.translate(inputWord, to: 'vi');
      print(translatorResult.text);
      return translatorResult.text;
    } catch (e) {
      print(Exception(e));
    }

    return "Can't translate";
  }

  //fetch similar vocab from api
  Future<List<Vocab>> getSimilarVocab(String word) async {
    List<Vocab> vocabList = [];
    try {
      //fetch api using http
      var apiURL = APIPath.wordSimilarity + word;
      var response = await Dio().get(apiURL);

      //check if reponse
      if (response.statusCode == 200) {
        //parse response to list of vocab
        var data = response.data;
        for (var i = 0; i < data.length; i++) {
          Vocab vocab = Vocab.fromJson(data[i]);
          vocabList.add(vocab);
        }
      }
    } catch (e) {
      print(Exception(e));
    }

    return vocabList;
  }
}

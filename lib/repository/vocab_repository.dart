import 'package:dio/dio.dart';
import 'package:english_learner/models/vocabulary.dart';
import 'package:english_learner/utils/constants.dart';

class VocabRepository {
  Future<List<Vocabulary>> getSimilarVocab(String word) async {
    List<Vocabulary> vocabList = [];
    try {
      //fetch api using http
      var apiURL = APIPath.wordSimilarity + word;
      var response = await Dio().get(apiURL);

      //check if reponse
      if (response.statusCode == 200) {
        //parse response to list of vocab
        var data = response.data;
        for (var i = 0; i < data.length; i++) {
          var vocab = Vocabulary.fromJson(data[i]);
          vocabList.add(vocab);
        }
      }
    } catch (e) {
      throw Exception(e);
    }

    return vocabList;
  }
}

import 'package:english_learner/utils/converter.dart';

class VocabWordSimilarity {
  final String word;
  final double accuracy;

  VocabWordSimilarity({required this.word, required this.accuracy});

  //from json
  factory VocabWordSimilarity.fromJson(Map<String, dynamic> json) {
    return VocabWordSimilarity(
      word: json['name'] != null
          ? CustomConverter.convertToString(json['name'])
          : '',
      accuracy: json['value'] != null
          ? CustomConverter.convertToDouble(json['value'])
          : 0.0,
    );
  }

  //from local list<dynamic>
  factory VocabWordSimilarity.fromLocalJson(List<dynamic> json) {
    return VocabWordSimilarity(
      word: json[0].toString(),
      accuracy: json[1].toDouble(),
    );
  }
}

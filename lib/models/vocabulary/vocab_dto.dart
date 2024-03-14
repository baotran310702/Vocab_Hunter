import 'package:english_learner/utils/converter.dart';

class VocabDTO {
  final String word;
  final double accuracy;

  VocabDTO({required this.word, required this.accuracy});

  //from json
  factory VocabDTO.fromJson(Map<String, dynamic> json) {
    return VocabDTO(
      word: json['name'] != null
          ? CustomConverter.convertToString(json['name'])
          : '',
      accuracy: json['value'] != null
          ? CustomConverter.convertToDouble(json['value'])
          : 0.0,
    );
  }
}

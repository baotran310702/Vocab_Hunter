import 'package:english_learner/utils/converter.dart';

class Vocab {
  final String word;
  final double accuracy;

  Vocab({required this.word, required this.accuracy});

  //from json
  factory Vocab.fromJson(Map<String, dynamic> json) {

    return Vocab(
      word: json['name'] != null ? CustomConverter.convertToString(json['name']) : '',
      accuracy: json['value']!=null ? CustomConverter.convertToDouble(json['value']) : 0.0, 
    );
  }
  
}

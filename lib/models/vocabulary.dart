import 'package:english_learner/utils/converter.dart';
import 'package:equatable/equatable.dart';

enum typeVocab{adj, adv, noun, verb}



class Vocabulary extends Equatable {
  final String vocabId;
  final Map<String,List<String>> meaning;
  final List<String> example;
  final List<String> pronunciation;
  final String? imageUrl;

  const Vocabulary({
    required this.vocabId,
    required this.meaning,
    required this.example,
    required this.pronunciation,
    this.imageUrl = "",
  });

  factory Vocabulary.fromJson(Map<String, dynamic> json) {
    return Vocabulary(
      vocabId:json['vocabId'] != null ? CustomConverter.convertToString(json['vocabId']) : "",
      meaning: json['meaning'] != null ? CustomConverter.convertToMeanings(json['meaning']) : "",
      example: json['example'] != null ? List.from(json['example']) : [],
      pronunciation: json['pronunciation'] != null ? List.from(json['pronunciation']) : [],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vocabId': vocabId,
      'meaning': meaning,
      'example': example,
      'pronunciation': pronunciation,
      'imageUrl': imageUrl,
    };
  }

  Vocabulary copyWith({
    String? vocabId,
    Map<String,List<String>>? meaning,
    List<String>? example,  
    List<String>? pronunciation,
    String? imageUrl,
  }) {
    return Vocabulary(
      vocabId: vocabId ?? this.vocabId,
      meaning: meaning ?? this.meaning,
      example: example ?? this.example,
    
      pronunciation: pronunciation ?? this.pronunciation,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props =>
      [vocabId, meaning, example, pronunciation, imageUrl];
}

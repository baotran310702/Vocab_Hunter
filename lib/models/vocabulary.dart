import 'package:english_learner/utils/converter.dart';
import 'package:equatable/equatable.dart';

class Vocabulary extends Equatable {
  final String word;
  final String meaning;
  final String example;
  final String type;
  final String pronunciation;
  final String? imageUrl;

  const Vocabulary({
    required this.word,
    required this.meaning,
    required this.example,
    required this.type,
    required this.pronunciation,
    this.imageUrl = "",
  });

  factory Vocabulary.fromJson(Map<String, dynamic> json) {
    return Vocabulary(
      word:json['word'] != null ? CustomConverter.convertToString(json['word']) : "",
      meaning: json['meaning'] != null ? CustomConverter.convertToString(json['meaning']) : "",
      example: json['example'] != null ? CustomConverter.convertToString(json['example']) : "",
      type: json['type'] != null ? CustomConverter.convertToString(json['type']) : "",
      pronunciation: json['pronunciation'] != null ? CustomConverter.convertToString(json['pronunciation']) : "",
      imageUrl: json['imageUrl'] != null ? CustomConverter.convertToString(json['imageUrl']) : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'meaning': meaning,
      'example': example,
      'type': type,
      'pronunciation': pronunciation,
      'imageUrl': imageUrl,
    };
  }

  Vocabulary copyWith({
    String? word,
    String? meaning,
    String? example,
    String? type,
    String? pronunciation,
    String? imageUrl,
  }) {
    return Vocabulary(
      word: word ?? this.word,
      meaning: meaning ?? this.meaning,
      example: example ?? this.example,
      type: type ?? this.type,
      pronunciation: pronunciation ?? this.pronunciation,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props =>
      [word, meaning, example, type, pronunciation, imageUrl];
}

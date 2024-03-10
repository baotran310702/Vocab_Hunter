import 'package:english_learner/utils/converter.dart';
import 'package:equatable/equatable.dart';

enum TypeVocab { adj, adv, noun, verb }

class Vocabulary extends Equatable {
  final String vocabId;
  final Map<String, List<String>> meaning;
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
      vocabId: json['vocabId'] != null
          ? CustomConverter.convertToString(json['vocabId'])
          : "",
      meaning: json['meaning'] != null
          ? CustomConverter.convertToMeanings(json['meaning'])
          : "",
      example: json['example'] != null ? List.from(json['example']) : [],
      pronunciation:
          json['pronunciation'] != null ? List.from(json['pronunciation']) : [],
      imageUrl: json['imageUrl'],
    );
  }

  factory Vocabulary.empty() {
    return const Vocabulary(
      vocabId: "",
      meaning: {},
      example: [],
      pronunciation: [],
      imageUrl: "",
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
    Map<String, List<String>>? meaning,
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

  static List<Vocabulary> seedData = const [
    Vocabulary(
      vocabId: 'hello',
      meaning: {
        'noun': ['xin chào'],
        'verb': ['chào']
      },
      example: ['Hello, how are you?'],
      pronunciation: ['həˈloʊ'],
      imageUrl: 'https://www.google.com.vn',
    ),
    Vocabulary(
      vocabId: 'world',
      meaning: {
        'noun': ['thế giới']
      },
      example: ['The world is beautiful'],
      pronunciation: ['wɜːrld'],
      imageUrl: 'https://www.google.com.vn',
    ),
    Vocabulary(
      vocabId: 'beautiful',
      meaning: {
        'adj': ['đẹp']
      },
      example: ['She is very beautiful'],
      pronunciation: ['ˈbjuːtɪfl'],
      imageUrl: 'https://www.google.com.vn',
    ),
  ];
}

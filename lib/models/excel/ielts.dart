class IeltsVocab {
  final String word;
  final String meaning;
  final String pronouce;
  final String topic;

  IeltsVocab({
    required this.word,
    required this.meaning,
    required this.pronouce,
    required this.topic,
  });

  factory IeltsVocab.fromJson(Map<String, dynamic> json) {
    return IeltsVocab(
      word: json['word'],
      meaning: json['meaning'],
      pronouce: json['pronouce'],
      topic: json['topic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'meaning': meaning,
      'pronouce': pronouce,
      'topic': topic,
    };
  }
}

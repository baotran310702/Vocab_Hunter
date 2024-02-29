class User {
  final String uid;
  final String userName;
  final int rank;
  final List<String> learnedWords;
  final List<String> recommendedVocabs;

  const User({
    required this.uid,
    required this.userName,
    required this.rank,
    required this.learnedWords,
    required this.recommendedVocabs,
  });

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    final String userName = data['userName'];
    final int rank = data['rank'];
    final List<dynamic> learnedWords = data['learnedWords'];
    final List<dynamic> recommendedVocabs = data['recommendedVocabs'];

    return User(
      uid: documentId,
      userName: userName,
      rank: rank,
      learnedWords: learnedWords.map((e) => e.toString()).toList(),
      recommendedVocabs: recommendedVocabs.map((e) => e.toString()).toList(),
    );
  }

  User copyWith({
    String? uid,
    String? userName,
    int? rank,
    List<String>? learnedWords,
    List<String>? recommendedVocabs,
  }) {
    return User(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      rank: rank ?? this.rank,
      learnedWords: learnedWords ?? this.learnedWords,
      recommendedVocabs: recommendedVocabs ?? this.recommendedVocabs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'rank': rank,
      'learnedWords': learnedWords,
      'recommendedVocabs': recommendedVocabs,
    };
  }
}

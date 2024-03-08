class User {
  final String uid;
  final String userName;
  final int rank;
  final List<String> learnedWords;
  final List<String> learningWors;

  const User({
    required this.uid,
    required this.userName,
    required this.rank,
    required this.learnedWords,
    required this.learningWors,
  });

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    final String userName = data['userName'];
    final int rank = data['rank'];
    final List<dynamic> learnedWords = data['learnedWords'];
    final List<dynamic> learningWors = data['learningWors'];

    return User(
      uid: documentId,
      userName: userName,
      rank: rank,
      learnedWords: learnedWords.map((e) => e.toString()).toList(),
      learningWors: learningWors.map((e) => e.toString()).toList(),
    );
  }

  User copyWith({
    String? uid,
    String? userName,
    int? rank,
    List<String>? learnedWords,
    List<String>? learningWors,
  }) {
    return User(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      rank: rank ?? this.rank,
      learnedWords: learnedWords ?? this.learnedWords,
      learningWors: learningWors ?? this.learningWors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'rank': rank,
      'learnedWords': learnedWords,
      'learningWors': learningWors,
    };
  }
}

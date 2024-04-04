class APIPath {
  static const String wordSimilarity = "https://wordsimilarity.com/data/en/";
  static const String dictionaryDev =
      "https://api.dictionaryapi.dev/api/v2/entries/en/";
  static const String wordSimilarityLocalhost =
      "http://192.168.100.183:5000/api/recommend-similar-words/";
}

class KeyLocalPreferences {
  static const String userId = 'userId';
  static const String token = 'token';
}

class KeyHiveLocal {
  static const int hiveUserId = 10;
  static const int hiveAchievementId = 11;
  static const int hiveVocabId = 12;
  static const int hiveEnumAchievementTypeId = 13;
  static const int hiveEnumWordTypeId = 14;
  static const int hiveTimeNotificationId = 15;
  static const int hiveVocabRemote = 16;
  static const int hivePhonestic = 17;
  static const int hiveMeanings = 18;
  static const int hiveDefinitions = 19;
}

class KeyBoxHiveLocal {
  static const String userKeyBox = 'userKeyBox';
  static const String achievementKeyBox = 'achievementKeyBox';
  static const String timeNotificationKeyBox = 'timeNotificationKeyBox';
  static const String vocabKeyBox = 'vocabKeyBox';
}

class APIPath {
  static const String wordSimilarity = "https://wordsimilarity.com/data/en/";
  static const String dictionaryDev =
      "https://api.dictionaryapi.dev/api/v2/entries/en/";
}

class KeyLocal {
  static const String userId = 'userId';
}

class KeyHiveLocal {
  static const int hiveUserId = 10;
  static const int hiveAchievementId = 11;
  static const int hiveVocabId = 12;
  static const int hiveEnumAchievementTypeId = 13;
  static const int hiveEnumWordTypeId = 14;
  static const int hiveTimeNotificationId = 15;
}

class KeyBoxHiveLocal {
  static const String userKeyBox = 'userKeyBox';
  static const String achievementKeyBox = 'achievementKeyBox';
  static const String timeNotificationKeyBox = 'timeNotificationKeyBox';
  static const String vocabKeyBox = 'vocabKeyBox';
}

class APIPath {
  static const String wordSimilarity = "https://wordsimilarity.com/data/en/";
  static const String dictionaryDev =
      "https://api.dictionaryapi.dev/api/v2/entries/en/";
  static const String wordSimilarityLocalhost =
      "http://192.168.2.82:5000/api/recommend-similar-words/";
}

class KeyLocalPreferences {
  static const String userId = 'userId';
  static const String token = 'token';
  static const String defaultListLearningVocab = 'defaultIdListLearningVocab';
}

class KeyHiveLocal {
  static const int hiveUserId = 31;
  static const int hiveAchievementId = 32;
  static const int hiveVocabId = 33;
  static const int hiveEnumAchievementTypeId = 34;
  static const int hiveEnumWordTypeId = 35;
  static const int hiveTimeNotificationId = 36;
  static const int hiveVocabRemote = 37;
  static const int hivePhonestic = 38;
  static const int hiveMeanings = 39;
  static const int hiveDefinitions = 40;
  static const int hiveUserVocab = 41;
  static const int hiveLiences = 42;
  static const int hiveEnumWordNoti = 43;
  static const int hiveWordNoti = 44;
  static const int hiveListTimeNotificationId = 45;
  static const int hiveListwordNotificationId = 46;
  static const int hiveTimeOfDay = 47;
}

class KeyBoxHiveLocal {
  static const String userKeyBox = 'userKeyBox';
  static const String achievementKeyBox = 'achievementKeyBox';
  static const String timeNotificationKeyBox = 'timeNotificationKeyBox';
  static const String listTimeNotificationKeyBox = 'listTimeNotificationKeyBox';
  static const String vocabKeyBox = 'vocabKeyBox';
  static const String listWordNotificationKeyBox = 'listWordNotificationKeyBox';
}

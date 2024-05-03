import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';

class GlobalDailyVocab {
  static final _instance = GlobalDailyVocab._internal();

  factory GlobalDailyVocab() {
    return _instance;
  }

  GlobalDailyVocab._internal();

  static final List<(VocabularyRemote, VocabularyRemote)> dailyVocab = [];

  void setDailyVocab(List<(VocabularyRemote, VocabularyRemote)> newDailyVocab) {
    dailyVocab.clear();
    dailyVocab.addAll(newDailyVocab);
  }

  List<(VocabularyRemote, VocabularyRemote)> getDailyVocab() {
    return dailyVocab;
  }
}

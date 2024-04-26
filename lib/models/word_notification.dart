import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';

import 'vocabulary/vocabulary_remote.dart';

part 'word_notification.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveEnumWordNoti)
enum ThresholdWords {
  @HiveField(0)
  lowFailure,
  @HiveField(1)
  mediumFailure,
  @HiveField(2)
  highFailure,
  @HiveField(3)
  lowSucess,
  @HiveField(4)
  mediumSucess,
  @HiveField(5)
  highSucess
}

@HiveType(typeId: KeyHiveLocal.hiveWordNoti)
class WordNotification {
  @HiveField(0)
  final (VocabularyRemote, VocabularyRemote) words;
  @HiveField(1)
  final int failureCount;
  @HiveField(2)
  final int successCount;
  @HiveField(3)
  final ThresholdWords thresholdWords;

  WordNotification({
    required this.words,
    required this.failureCount,
    required this.successCount,
    required this.thresholdWords,
  });
}

@HiveType(typeId: KeyHiveLocal.hiveListwordNotificationId)
class ListWordNotification {
  @HiveField(0)
  final List<WordNotification> listWordNotification;
  ListWordNotification({
    required this.listWordNotification,
  });

  factory ListWordNotification.empty() {
    return ListWordNotification(listWordNotification: []);
  }
}

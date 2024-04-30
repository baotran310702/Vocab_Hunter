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
  final VocabularyRemote englishWords;
  @HiveField(1)
  final VocabularyRemote vietnameseWords;
  @HiveField(2)
  final int failureCount;
  @HiveField(3)
  final int successCount;
  @HiveField(4)
  final ThresholdWords thresholdWords;

  WordNotification({
    required this.englishWords,
    required this.vietnameseWords,
    required this.failureCount,
    required this.successCount,
    required this.thresholdWords,
  });

  factory WordNotification.empty() {
    return WordNotification(
      englishWords: VocabularyRemote.empty(),
      vietnameseWords: VocabularyRemote.empty(),
      failureCount: 0,
      successCount: 0,
      thresholdWords: ThresholdWords.lowFailure,
    );
  }

  WordNotification copyWith({
    VocabularyRemote? englishWords,
    VocabularyRemote? vietnameseWords,
    int? failureCount,
    int? successCount,
    ThresholdWords? thresholdWords,
  }) {
    return WordNotification(
      englishWords: englishWords ?? this.englishWords,
      vietnameseWords: vietnameseWords ?? this.vietnameseWords,
      failureCount: failureCount ?? this.failureCount,
      successCount: successCount ?? this.successCount,
      thresholdWords: thresholdWords ?? this.thresholdWords,
    );
  }
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

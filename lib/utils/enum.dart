import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';

part 'enum.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveEnumAchievementTypeId)
enum AchievementType {
  @HiveField(0)
  capyEating,
  @HiveField(1)
  capySleeping,
  @HiveField(2)
  capyWritting,
  @HiveField(3)
  capyBathing,
  @HiveField(4)
  capyGraduate,
  @HiveField(5)
  capyGraduate1,
  @HiveField(6)
  capyCow,
  @HiveField(7)
  capyCoca,
  @HiveField(8)
  capyGuitar,
  @HiveField(9)
  capyCooking,
  @HiveField(10)
  capyRabbit,
  @HiveField(11)
  capyDoctor
}

@HiveType(typeId: KeyHiveLocal.hiveEnumWordTypeId)
enum WordType {
  @HiveField(0)
  noun,
  @HiveField(1)
  adj,
  @HiveField(2)
  adv,
  @HiveField(3)
  verb,
  @HiveField(4)
  undefined
}

enum DownloadStatus { notDownloaded, dowloading, downloaded }

enum FlashCardType { topicWidget, listVocabWidget }

//advacned enum, can be used to set value for enum
@HiveType(typeId: KeyHiveLocal.hiveSexLocal)
enum Sex {
  @HiveField(0)
  man('Man'),
  @HiveField(1)
  woman('Woman');

  final String value;
  const Sex(this.value);

  Sex reverse() {
    if (value.trim().toLowerCase() == 'man') {
      return Sex.woman;
    }
    if (value.trim().toLowerCase() == 'woman') {
      return Sex.man;
    }
    return Sex.woman;
  }
}

enum CustomAchievement {
  topic('Topic'),
  vocab('Vocabulary'),
  trainRoom('Train room');

  final String value;
  const CustomAchievement(this.value);
}

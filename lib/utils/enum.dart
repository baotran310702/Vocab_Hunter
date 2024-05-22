import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';

part 'enum.g.dart';

@HiveType(typeId: KeyHiveLocal.hiveEnumAchievementTypeId)
enum AchievementType {
  @HiveField(0)
  eatingBoi,
  @HiveField(1)
  sleepyBoi,
  @HiveField(2)
  writingBoi,
  @HiveField(3)
  bathingBoi,
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

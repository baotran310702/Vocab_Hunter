// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AchievementTypeAdapter extends TypeAdapter<AchievementType> {
  @override
  final int typeId = 34;

  @override
  AchievementType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AchievementType.capyEating;
      case 1:
        return AchievementType.capySleeping;
      case 2:
        return AchievementType.capyWritting;
      case 3:
        return AchievementType.capyBathing;
      case 4:
        return AchievementType.capyGraduate;
      case 5:
        return AchievementType.capyGraduate1;
      case 6:
        return AchievementType.capyCow;
      case 7:
        return AchievementType.capyCoca;
      case 8:
        return AchievementType.capyGuitar;
      case 9:
        return AchievementType.capyCooking;
      case 10:
        return AchievementType.capyRabbit;
      case 11:
        return AchievementType.capyDoctor;
      case 12:
        return AchievementType.capyNoti;
      default:
        return AchievementType.capyEating;
    }
  }

  @override
  void write(BinaryWriter writer, AchievementType obj) {
    switch (obj) {
      case AchievementType.capyEating:
        writer.writeByte(0);
        break;
      case AchievementType.capySleeping:
        writer.writeByte(1);
        break;
      case AchievementType.capyWritting:
        writer.writeByte(2);
        break;
      case AchievementType.capyBathing:
        writer.writeByte(3);
        break;
      case AchievementType.capyGraduate:
        writer.writeByte(4);
        break;
      case AchievementType.capyGraduate1:
        writer.writeByte(5);
        break;
      case AchievementType.capyCow:
        writer.writeByte(6);
        break;
      case AchievementType.capyCoca:
        writer.writeByte(7);
        break;
      case AchievementType.capyGuitar:
        writer.writeByte(8);
        break;
      case AchievementType.capyCooking:
        writer.writeByte(9);
        break;
      case AchievementType.capyRabbit:
        writer.writeByte(10);
        break;
      case AchievementType.capyDoctor:
        writer.writeByte(11);
        break;
      case AchievementType.capyNoti:
        writer.writeByte(12);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AchievementTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WordTypeAdapter extends TypeAdapter<WordType> {
  @override
  final int typeId = 35;

  @override
  WordType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WordType.noun;
      case 1:
        return WordType.adj;
      case 2:
        return WordType.adv;
      case 3:
        return WordType.verb;
      case 4:
        return WordType.undefined;
      default:
        return WordType.noun;
    }
  }

  @override
  void write(BinaryWriter writer, WordType obj) {
    switch (obj) {
      case WordType.noun:
        writer.writeByte(0);
        break;
      case WordType.adj:
        writer.writeByte(1);
        break;
      case WordType.adv:
        writer.writeByte(2);
        break;
      case WordType.verb:
        writer.writeByte(3);
        break;
      case WordType.undefined:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SexAdapter extends TypeAdapter<Sex> {
  @override
  final int typeId = 55;

  @override
  Sex read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Sex.man;
      case 1:
        return Sex.woman;
      default:
        return Sex.man;
    }
  }

  @override
  void write(BinaryWriter writer, Sex obj) {
    switch (obj) {
      case Sex.man:
        writer.writeByte(0);
        break;
      case Sex.woman:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SexAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CustomAchievementAdapter extends TypeAdapter<CustomAchievement> {
  @override
  final int typeId = 57;

  @override
  CustomAchievement read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CustomAchievement.topic;
      case 1:
        return CustomAchievement.vocab;
      case 2:
        return CustomAchievement.trainRoom;
      default:
        return CustomAchievement.topic;
    }
  }

  @override
  void write(BinaryWriter writer, CustomAchievement obj) {
    switch (obj) {
      case CustomAchievement.topic:
        writer.writeByte(0);
        break;
      case CustomAchievement.vocab:
        writer.writeByte(1);
        break;
      case CustomAchievement.trainRoom:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomAchievementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

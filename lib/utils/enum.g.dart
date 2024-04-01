// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AchievementTypeAdapter extends TypeAdapter<AchievementType> {
  @override
  final int typeId = 13;

  @override
  AchievementType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AchievementType.eatingBoi;
      case 1:
        return AchievementType.sleepyBoi;
      case 2:
        return AchievementType.writingBoi;
      case 3:
        return AchievementType.bathingBoi;
      default:
        return AchievementType.eatingBoi;
    }
  }

  @override
  void write(BinaryWriter writer, AchievementType obj) {
    switch (obj) {
      case AchievementType.eatingBoi:
        writer.writeByte(0);
        break;
      case AchievementType.sleepyBoi:
        writer.writeByte(1);
        break;
      case AchievementType.writingBoi:
        writer.writeByte(2);
        break;
      case AchievementType.bathingBoi:
        writer.writeByte(3);
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
  final int typeId = 14;

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

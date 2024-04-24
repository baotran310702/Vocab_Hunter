// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordNotificationAdapter extends TypeAdapter<WordNotification> {
  @override
  final int typeId = 23;

  @override
  WordNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordNotification(
      words: fields[0] as (VocabularyRemote, VocabularyRemote),
      failureCount: fields[1] as int,
      successCount: fields[2] as int,
      thresholdWords: fields[3] as ThresholdWords,
    );
  }

  @override
  void write(BinaryWriter writer, WordNotification obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.words)
      ..writeByte(1)
      ..write(obj.failureCount)
      ..writeByte(2)
      ..write(obj.successCount)
      ..writeByte(3)
      ..write(obj.thresholdWords);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThresholdWordsAdapter extends TypeAdapter<ThresholdWords> {
  @override
  final int typeId = 22;

  @override
  ThresholdWords read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThresholdWords.lowFailure;
      case 1:
        return ThresholdWords.mediumFailure;
      case 2:
        return ThresholdWords.highFailure;
      case 3:
        return ThresholdWords.lowSucess;
      case 4:
        return ThresholdWords.mediumSucess;
      case 5:
        return ThresholdWords.highSucess;
      default:
        return ThresholdWords.lowFailure;
    }
  }

  @override
  void write(BinaryWriter writer, ThresholdWords obj) {
    switch (obj) {
      case ThresholdWords.lowFailure:
        writer.writeByte(0);
        break;
      case ThresholdWords.mediumFailure:
        writer.writeByte(1);
        break;
      case ThresholdWords.highFailure:
        writer.writeByte(2);
        break;
      case ThresholdWords.lowSucess:
        writer.writeByte(3);
        break;
      case ThresholdWords.mediumSucess:
        writer.writeByte(4);
        break;
      case ThresholdWords.highSucess:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThresholdWordsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary_topic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabularyByTopicAdapter extends TypeAdapter<VocabularyByTopic> {
  @override
  final int typeId = 50;

  @override
  VocabularyByTopic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabularyByTopic(
      word: fields[0] as String,
      meaning: fields[1] as String,
      pronouce: fields[2] as String,
      topic: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VocabularyByTopic obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.meaning)
      ..writeByte(2)
      ..write(obj.pronouce)
      ..writeByte(3)
      ..write(obj.topic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabularyByTopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

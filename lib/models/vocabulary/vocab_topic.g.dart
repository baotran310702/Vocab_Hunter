// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocab_topic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabTopicAdapter extends TypeAdapter<VocabTopic> {
  @override
  final int typeId = 52;

  @override
  VocabTopic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabTopic(
      word: fields[0] as String,
      pronounce: fields[1] as String,
      type: fields[2] as String,
      meaning: fields[3] as String,
      exampleEnglish: fields[4] as String,
      exampleVietnamese: fields[5] as String,
      topic: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VocabTopic obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.pronounce)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.meaning)
      ..writeByte(4)
      ..write(obj.exampleEnglish)
      ..writeByte(5)
      ..write(obj.exampleVietnamese)
      ..writeByte(6)
      ..write(obj.topic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabTopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

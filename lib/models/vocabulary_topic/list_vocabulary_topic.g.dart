// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_vocabulary_topic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListVocabularyTopicAdapter extends TypeAdapter<ListVocabularyTopic> {
  @override
  final int typeId = 51;

  @override
  ListVocabularyTopic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListVocabularyTopic(
      topic: fields[0] as String,
      vocabularyByTopic: (fields[1] as List).cast<VocabularyByTopic>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListVocabularyTopic obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.topic)
      ..writeByte(1)
      ..write(obj.vocabularyByTopic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListVocabularyTopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

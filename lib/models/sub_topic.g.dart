// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_topic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubTopicAdapter extends TypeAdapter<SubTopic> {
  @override
  final int typeId = 54;

  @override
  SubTopic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubTopic(
      name: fields[1] as String,
      image: fields[2] as String,
      description: fields[3] as String,
      subTopicId: fields[0] as String,
      amountVocab: fields[4] as int,
      isLiked: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SubTopic obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.subTopicId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.amountVocab)
      ..writeByte(5)
      ..write(obj.isLiked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubTopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vocab.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserVocabAdapter extends TypeAdapter<UserVocab> {
  @override
  final int typeId = 20;

  @override
  UserVocab read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserVocab(
      listName: fields[0] as String,
      listVocabulary: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserVocab obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.listName)
      ..writeByte(1)
      ..write(obj.listVocabulary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserVocabAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

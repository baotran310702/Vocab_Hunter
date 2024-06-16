// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 31;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      uid: fields[0] as String,
      userName: fields[1] as String,
      rank: fields[2] as int,
      learnedWords: (fields[4] as List).cast<UserVocab>(),
      achievements: (fields[3] as List).cast<Achievement>(),
      learningWords: (fields[5] as List).cast<UserVocab>(),
      phoneNumber: fields[6] as String,
      sex: fields[7] as Sex,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.rank)
      ..writeByte(3)
      ..write(obj.achievements)
      ..writeByte(4)
      ..write(obj.learnedWords)
      ..writeByte(5)
      ..write(obj.learningWords)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.sex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

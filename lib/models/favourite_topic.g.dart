// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_topic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListFavouriteTopicAdapter extends TypeAdapter<ListFavouriteTopic> {
  @override
  final int typeId = 56;

  @override
  ListFavouriteTopic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListFavouriteTopic(
      favouriteTopics: (fields[0] as List).cast<Topic>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListFavouriteTopic obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.favouriteTopics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListFavouriteTopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

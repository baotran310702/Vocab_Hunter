// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocab_translated_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabTranslatedLocalModelAdapter
    extends TypeAdapter<VocabTranslatedLocalModel> {
  @override
  final int typeId = 48;

  @override
  VocabTranslatedLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabTranslatedLocalModel(
      englishWords: fields[0] as VocabularyRemote,
      vietnameseWords: fields[1] as VocabularyRemote,
    );
  }

  @override
  void write(BinaryWriter writer, VocabTranslatedLocalModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.englishWords)
      ..writeByte(1)
      ..write(obj.vietnameseWords);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabTranslatedLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ListVocabTranslatedAdapter extends TypeAdapter<ListVocabTranslated> {
  @override
  final int typeId = 49;

  @override
  ListVocabTranslated read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListVocabTranslated(
      listVocabTranslated:
          (fields[0] as List).cast<VocabTranslatedLocalModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListVocabTranslated obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.listVocabTranslated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListVocabTranslatedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

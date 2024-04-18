// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary_remote.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabularyRemoteAdapter extends TypeAdapter<VocabularyRemote> {
  @override
  final int typeId = 16;

  @override
  VocabularyRemote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabularyRemote(
      word: fields[0] as String?,
      phonetic: fields[1] as String?,
      phonetics: (fields[2] as List?)?.cast<Phonetics>(),
      meanings: (fields[3] as List?)?.cast<Meanings>(),
      license: fields[4] as License?,
      sourceUrls: (fields[5] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, VocabularyRemote obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.phonetic)
      ..writeByte(2)
      ..write(obj.phonetics)
      ..writeByte(3)
      ..write(obj.meanings)
      ..writeByte(4)
      ..write(obj.license)
      ..writeByte(5)
      ..write(obj.sourceUrls);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabularyRemoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PhoneticsAdapter extends TypeAdapter<Phonetics> {
  @override
  final int typeId = 17;

  @override
  Phonetics read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Phonetics(
      text: fields[0] as String?,
      audio: fields[1] as String?,
      sourceUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Phonetics obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.audio)
      ..writeByte(2)
      ..write(obj.sourceUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneticsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MeaningsAdapter extends TypeAdapter<Meanings> {
  @override
  final int typeId = 18;

  @override
  Meanings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meanings(
      partOfSpeech: fields[0] as String?,
      definitions: (fields[1] as List?)?.cast<Definitions>(),
      synonyms: (fields[2] as List?)?.cast<String>(),
      antonyms: (fields[3] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Meanings obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.partOfSpeech)
      ..writeByte(1)
      ..write(obj.definitions)
      ..writeByte(2)
      ..write(obj.synonyms)
      ..writeByte(3)
      ..write(obj.antonyms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeaningsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DefinitionsAdapter extends TypeAdapter<Definitions> {
  @override
  final int typeId = 19;

  @override
  Definitions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Definitions(
      definition: fields[0] as String?,
      synonyms: (fields[1] as List?)?.cast<String>(),
      antonyms: (fields[2] as List?)?.cast<String>(),
      example: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Definitions obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.definition)
      ..writeByte(1)
      ..write(obj.synonyms)
      ..writeByte(2)
      ..write(obj.antonyms)
      ..writeByte(3)
      ..write(obj.example);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DefinitionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LicenseAdapter extends TypeAdapter<License> {
  @override
  final int typeId = 21;

  @override
  License read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return License(
      name: fields[0] as String?,
      url: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, License obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LicenseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

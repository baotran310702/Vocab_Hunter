import 'dart:convert';

import 'package:english_learner/utils/converter.dart';

class VocabularyRemote {
  String? word;
  String? phonetic;
  List<Phonetics>? phonetics;
  List<Meanings>? meanings;
  License? license;
  List<String>? sourceUrls;

  VocabularyRemote(
      {this.word,
      this.phonetic,
      this.phonetics,
      this.meanings,
      this.license,
      this.sourceUrls});

  VocabularyRemote.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    phonetic = json['phonetic'];
    if (json['phonetics'] != null) {
      phonetics = <Phonetics>[];
      json['phonetics'].forEach((v) {
        phonetics!.add(Phonetics.fromJson(v));
      });
    }
    if (json['meanings'] != null) {
      meanings = <Meanings>[];
      json['meanings'].forEach((v) {
        meanings!.add(Meanings.fromJson(v));
      });
    }
    license =
        json['license'] != null ? License.fromJson(json['license']) : null;
    sourceUrls = json['sourceUrls'].cast<String>();
  }

  //create an empty Vocabularyremote
  VocabularyRemote.empty() {
    word = '';
    phonetic = '';
    phonetics = <Phonetics>[];
    meanings = <Meanings>[];
    license = License(name: '', url: '');
    sourceUrls = <String>[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    data['phonetic'] = phonetic;
    if (phonetics != null) {
      data['phonetics'] = phonetics!.map((v) => v.toJson()).toList();
    }
    if (meanings != null) {
      data['meanings'] = meanings!.map((v) => v.toJson()).toList();
    }
    if (license != null) {
      data['license'] = license!.toJson();
    }
    data['sourceUrls'] = sourceUrls;
    return data;
  }

  Map<String, dynamic> jsonVietnameseEncode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[CustomConverter.convertKeyVocabToId('word').toString()] = word;
    data[CustomConverter.convertKeyVocabToId('phonetic').toString()] = phonetic;
    if (phonetics != null) {
      data[CustomConverter.convertKeyVocabToId('phonetics').toString()] =
          phonetics!.map((v) => v.toVietnameseEncode()).toList();
    }
    if (meanings != null) {
      data[CustomConverter.convertKeyVocabToId('meanings').toString()] =
          meanings!.map((v) => v.toVietnameseEncode()).toList();
    }
    if (license != null) {
      data[CustomConverter.convertKeyVocabToId('license').toString()] =
          license!.toVietnameseEncode();
    }
    data[CustomConverter.convertKeyVocabToId('sourceUrls').toString()] =
        sourceUrls;
    return data;
  }
}

class Phonetics {
  String? text;
  String? audio;
  String? sourceUrl;

  Phonetics({this.text, this.audio, this.sourceUrl});

  Phonetics.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    audio = json['audio'];
    sourceUrl = json['sourceUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['audio'] = audio;
    data['sourceUrl'] = sourceUrl;
    return data;
  }

  Map<String, dynamic> toVietnameseEncode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[CustomConverter.convertKeyVocabToId('text').toString()] = text;
    data[CustomConverter.convertKeyVocabToId('audio').toString()] = audio;
    data[CustomConverter.convertKeyVocabToId('sourceUrl').toString()] =
        sourceUrl;
    return data;
  }
}

class Meanings {
  String? partOfSpeech;
  List<Definitions>? definitions;
  List<String>? synonyms;
  List<String>? antonyms;

  Meanings({this.partOfSpeech, this.definitions, this.synonyms, this.antonyms});

  Meanings.fromJson(Map<String, dynamic> json) {
    partOfSpeech = json['partOfSpeech'];
    if (json['definitions'] != null) {
      definitions = <Definitions>[];
      json['definitions'].forEach((v) {
        definitions!.add(Definitions.fromJson(v));
      });
    }
    synonyms = json['synonyms'].cast<String>();
    antonyms = json['antonyms'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partOfSpeech'] = partOfSpeech;
    if (definitions != null) {
      data['definitions'] = definitions!.map((v) => v.toJson()).toList();
    }
    data['synonyms'] = synonyms;
    data['antonyms'] = antonyms;
    return data;
  }

  Map<String, dynamic> toVietnameseEncode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[CustomConverter.convertKeyVocabToId('partOfSpeech').toString()] =
        partOfSpeech;
    if (definitions != null) {
      data[CustomConverter.convertKeyVocabToId('definitions').toString()] =
          definitions!.map((v) => v.toVietnameseEncode()).toList();
    }
    data[CustomConverter.convertKeyVocabToId('synonyms').toString()] = synonyms;
    data[CustomConverter.convertKeyVocabToId('antonyms').toString()] = antonyms;
    return data;
  }
}

class Definitions {
  String? definition;
  List<String>? synonyms;
  List<String>? antonyms;
  String? example;

  Definitions({this.definition, this.synonyms, this.antonyms, this.example});

  Definitions.fromJson(Map<String, dynamic> json) {
    definition = json['definition'];
    synonyms = json['synonyms'].cast<String>();
    antonyms = json['antonyms'].cast<String>();
    example = json['example'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['definition'] = definition;
    data['synonyms'] = synonyms;
    data['antonyms'] = antonyms;
    data['example'] = example;
    return data;
  }

  Map<String, dynamic> toVietnameseEncode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[CustomConverter.convertKeyVocabToId('definition').toString()] =
        definition;
    data[CustomConverter.convertKeyVocabToId('synonyms').toString()] = synonyms;
    data[CustomConverter.convertKeyVocabToId('antonyms').toString()] = antonyms;
    data[CustomConverter.convertKeyVocabToId('example').toString()] = example;
    return data;
  }
}

class License {
  String? name;
  String? url;

  License({this.name, this.url});

  License.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }

  Map<String, dynamic> toVietnameseEncode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[CustomConverter.convertKeyVocabToId('name').toString()] = name;
    data[CustomConverter.convertKeyVocabToId('url').toString()] = url;
    return data;
  }
}

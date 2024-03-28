import 'package:english_learner/services/translate_services.dart';

abstract class VocabularyRemoteService {
  TranslateServices services = TranslateServices();
}

class VocabularyRemote extends VocabularyRemoteService {
  String? word;
  String? phonetic;
  List<Phonetics>? phonetics;
  List<Meanings>? meanings;
  License? license;
  List<String>? sourceUrls;

  VocabularyRemote({
    this.word,
    this.phonetic,
    this.phonetics,
    this.meanings,
    this.license,
    this.sourceUrls,
  });

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

  Future<VocabularyRemote> toVietnamese() async {
    List<dynamic> vocabTranslate = await Future.wait([
      services.translatePerWordRemote(word ?? ""),
      meaningsTranslate(),
    ]);

    return VocabularyRemote(
      word: vocabTranslate[0].toString(),
      phonetic: phonetic,
      phonetics: phonetics,
      meanings: vocabTranslate[1] as List<Meanings>?,
      license: license,
      sourceUrls: sourceUrls,
    );
  }

  Future<List<Meanings>> meaningsTranslate() async {
    List<Meanings> result = [];

    if (meanings != null) {
      List<dynamic> resultTranslated = await Future.wait(
        meanings!.map((e) async {
          return await e.toVietnamese();
        }),
      );

      for (var item in resultTranslated) {
        result.add(item as Meanings);
      }
      return result;
    } else {
      return [];
    }
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
}

class Meanings extends VocabularyRemoteService {
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

  Future<Meanings> toVietnamese() async {
    List<Definitions> definitionsTranslated = await translateDefinitions();
    List<String> synonymsTranslated = await getVietnameseSynonyms();
    List<String> antonymsTranslated = await getVietNameseAtonyms();

    return Meanings(
      partOfSpeech: partOfSpeech,
      definitions: definitionsTranslated,
      synonyms: synonymsTranslated,
      antonyms: antonymsTranslated,
    );
  }

  Future<List<Definitions>> translateDefinitions() async {
    List<Definitions> result = [];
    if (definitions != null) {
      List<dynamic> resultTranslated = await Future.wait(
        definitions!.map((e) async {
          return await e.toVietnamese();
        }),
      );

      for (var item in resultTranslated) {
        result.add(item as Definitions);
      }
      return result;
    } else {
      return [];
    }
  }

  Future<List<String>> getVietnameseSynonyms() async {
    List<String> result = [];
    if (synonyms != null) {
      List<dynamic> vietnameses = await Future.wait(
        synonyms!.map((e) async {
          return await services.translatePerWordRemote(e);
        }),
      );
      for (var item in vietnameses) {
        result.add(item.toString());
      }
      return result;
    }
    return [];
  }

  Future<List<String>> getVietNameseAtonyms() async {
    List<String> result = [];
    if (antonyms != null) {
      List<dynamic> vietnameses = await Future.wait(
        antonyms!.map((e) async {
          return await services.translatePerWordRemote(e);
        }),
      );
      for (var item in vietnameses) {
        result.add(item.toString());
      }
      return result;
    }
    return [];
  }
}

class Definitions extends VocabularyRemoteService {
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

  Future<Definitions> toVietnamese() async {
    String definitionTranslated = await getVietnameseDefinition();
    List<String> synonymsTranslated = await getVietnameseSynonyms();
    List<String> antonymsTranslated = await getVietNameseAtonyms();
    String exampleTranslated = await getVietnameseExample();

    return Definitions(
      definition: definitionTranslated,
      synonyms: synonymsTranslated,
      antonyms: antonymsTranslated,
      example: exampleTranslated,
    );
  }

  Future<String> getVietnameseDefinition() async {
    return definition != null
        ? await services.translatePerWordRemote(definition!)
        : "";
  }

  Future<String> getVietnameseExample() async {
    return example != null
        ? await services.translatePerWordRemote(example!)
        : "";
  }

  Future<List<String>> getVietnameseSynonyms() async {
    List<String> result = [];
    if (synonyms != null) {
      List<dynamic> vietnameses = await Future.wait(
        synonyms!.map((e) async {
          return await services.translatePerWordRemote(e);
        }),
      );
      for (var item in vietnameses) {
        result.add(item.toString());
      }
      return result;
    }
    return [];
  }

  Future<List<String>> getVietNameseAtonyms() async {
    List<String> result = [];
    if (antonyms != null) {
      List<dynamic> vietnameses = await Future.wait(
        antonyms!.map((e) async {
          return await services.translatePerWordRemote(e);
        }),
      );
      for (var item in vietnameses) {
        result.add(item.toString());
      }
      return result;
    }
    return [];
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
}

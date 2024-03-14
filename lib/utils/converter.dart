import 'package:english_learner/utils/word_type.dart';

class CustomConverter {
  // convert anytype to string
  static String convertToString(dynamic value) {
    if (value is String) {
      return value;
    } else if (value is int) {
      return value.toString();
    } else if (value is double) {
      return value.toString();
    } else if (value is bool) {
      return value.toString();
    } else if (value is List) {
      return value.join(",");
    } else {
      return value.toString();
    }
  }

  static convertToMeaningsFirebase(Map<String, List<String>> json) {
    return {
      'adj': json['adj'],
      'verb': json['verb'],
      'adv': json['adv'],
      'noun': json['noun'],
      'default': json['noun'],
    };
  }

  //write a function that convert anytype to double
  static double convertToDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is bool) {
      return value ? 1.0 : 0.0;
    } else {
      return 0.0;
    }
  }

  static Map<String, List<String>> convertToMeaningLocal(
      List<dynamic> meaning1, List<dynamic> meaning2) {
    Map<String, List<String>> result = {};

    List<String> raw = meaning1[0].toString().split(":");

    List<String> meaningVietnames = raw.length > 1 ? raw[1].split(',') : [];

    result.addAll({
      raw[0]: [...meaningVietnames]
    });

    String wordTypes =
        raw[0].split(',').isNotEmpty ? raw[0].split(',')[0] : raw[0];

    result.addAll({
      WordTypeExt.fromVietNameseToEnglish(wordTypes): [
        ...meaning2[0].toString().split(',')
      ]
    });

    return result;
  }

  static int convertKeyVocabToId(String key) {
    switch (key) {
      case 'word':
        return 1;
      case 'phonetic':
        return 2;
      case 'phonetics':
        return 17;
      case 'meanings':
        return 3;
      case 'license':
        return 4;
      case 'sourceUrls':
        return 5;
      case 'text':
        return 6;
      case 'audio':
        return 7;
      case 'sourceUrl':
        return 8;
      case 'partOfSpeech':
        return 9;
      case 'definitions':
        return 10;
      case 'definition':
        return 11;
      case 'synonyms':
        return 12;
      case 'antonyms':
        return 13;
      case 'example':
        return 14;
      case 'name':
        return 15;
      case 'url':
        return 16;
      default:
        return 0;
    }
  }

  static String convertIdVocabToString(int id) {
    switch (id) {
      case 1:
        return 'word';
      case 2:
        return 'phonetic';
      case 17:
        return 'phonetics';
      case 3:
        return 'meanings';
      case 4:
        return 'license';
      case 5:
        return 'sourceUrls';
      case 6:
        return 'text';
      case 7:
        return 'audio';
      case 8:
        return 'sourceUrl';
      case 9:
        return 'partOfSpeech';
      case 10:
        return 'definitions';
      case 11:
        return 'definition';
      case 12:
        return 'synonyms';
      case 13:
        return 'antonyms';
      case 14:
        return 'example';
      case 15:
        return 'name';
      case 16:
        return 'url';
      default:
        return '';
    }
  }
}

import 'enum.dart';

class WordTypeExt {
  static String getEnglishWord(WordType type) {
    switch (type) {
      case WordType.noun:
        return "Noun";
      case WordType.adj:
        return "Adjective";
      case WordType.adv:
        return "Adverb";
      case WordType.verb:
        return "Verb";
      default:
        return "";
    }
  }

  static String getVietnameseWord(WordType type) {
    switch (type) {
      case WordType.noun:
        return "Danh từ";
      case WordType.adj:
        return "Tính từ";
      case WordType.adv:
        return "Trạng từ";
      case WordType.verb:
        return "Động từ";
      default:
        return "";
    }
  }

  static WordType fromEnglish(String type) {
    switch (type.toLowerCase()) {
      case "noun":
        return WordType.noun;
      case "adjective":
        return WordType.adj;
      case "adverb":
        return WordType.adv;
      case "verb":
        return WordType.verb;
      default:
        return WordType.undefined;
    }
  }

  static WordType fromVietNamese(String type) {
    switch (type.toLowerCase()) {
      case "danh từ":
        return WordType.noun;
      case "tính từ":
        return WordType.adj;
      case "trạng từ":
        return WordType.adv;
      case "động từ":
        return WordType.verb;
      default:
        return WordType.undefined;
    }
  }

  static String fromVietNameseToEnglish(String type) {
    switch (type.toLowerCase()) {
      case "danh từ":
        return "Noun";
      case "tính từ":
        return "Adjective";
      case "trạng từ":
        return "Adverb";
      case "động từ":
        return "Verb";
      default:
        return "";
    }
  }

  static String fromEnglishToVietNamese(String type) {
    switch (type.toLowerCase()) {
      case "noun":
        return "Danh từ";
      case "adjective":
        return "Tính từ";
      case "adverb":
        return "Trạng từ";
      case "verb":
        return "Động từ";
      default:
        return "";
    }
  }

  static bool isEnglishWordType(String type) {
    switch (type.toLowerCase()) {
      case "noun":
        return true;
      case "adjective":
        return true;
      case "adverb":
        return true;
      case "verb":
        return true;
      default:
        return false;
    }
  }
}

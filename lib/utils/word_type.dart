enum WordType { noun, adj, adv, verb, undefined }

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
    switch (type) {
      case "Noun":
        return WordType.noun;
      case "Adjective":
        return WordType.adj;
      case "Adverb":
        return WordType.adv;
      case "Verb":
        return WordType.verb;
      default:
        return WordType.undefined;
    }
  }

  static WordType fromVietNamese(String type) {
    switch (type) {
      case "Danh từ":
        return WordType.noun;
      case "Tính từ":
        return WordType.adj;
      case "Trạng từ":
        return WordType.adv;
      case "Động từ":
        return WordType.verb;
      default:
        return WordType.undefined;
    }
  }

  static String fromVietNameseToEnglish(String type) {
    switch (type) {
      case "Danh từ":
        return "Noun";
      case "Tính từ":
        return "Adjective";
      case "Trạng từ":
        return "Adverb";
      case "Động từ":
        return "Verb";
      default:
        return "";
    }
  }

  static String fromEnglishToVietNamese(String type) {
    switch (type) {
      case "Noun":
        return "Danh từ";
      case "Adjective":
        return "Tính từ";
      case "Adverb":
        return "Trạng từ";
      case "Verb":
        return "Động từ";
      default:
        return "";
    }
  }

  static bool isEnglishWordType(String type) {
    switch (type) {
      case "Noun":
        return true;
      case "Adjective":
        return true;
      case "Adverb":
        return true;
      case "Verb":
        return true;
      default:
        return false;
    }
  }
}

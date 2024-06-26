import 'package:english_learner/utils/enum.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:english_learner/utils/word_type.dart';

class CustomConverter {
  /// Convert to String with dynamic type
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

  /// Convert dynamic to DateTime
  static DateTime convertToDateTime(dynamic value) {
    if (value is String) {
      return DateTime.parse(value);
    } else if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } else if (value is double) {
      return DateTime.fromMillisecondsSinceEpoch(value.toInt());
    } else {
      return DateTime.now();
    }
  }

  /// Convert to word type in firebase
  static convertToMeaningsFirebase(Map<String, List<String>> json) {
    return {
      'adj': json['adj'],
      'verb': json['verb'],
      'adv': json['adv'],
      'noun': json['noun'],
      'default': json['noun'],
    };
  }

  /// Convert to double with dynamic type
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

  /// Convert dynamic to int
  static int convertToInt(dynamic value) {
    if (value is String) {
      return int.parse(value);
    } else if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else if (value is bool) {
      return value ? 1 : 0;
    } else {
      return 0;
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

  static String convertAchievement(AchievementType type) {
    switch (type) {
      case AchievementType.bathingBoi:
        return AppIcons.bathingBoi;
      case AchievementType.eatingBoi:
        return AppIcons.eatingBoi;
      case AchievementType.sleepyBoi:
        return AppIcons.sleepyBoi;
      case AchievementType.writingBoi:
        return AppIcons.writingBoi;
      default:
        return "";
    }
  }

  static String convertVietnameseWordType(String wordType) {
    String currentWords = wordType.toLowerCase();
    switch (currentWords) {
      case "noun":
        return "Danh từ";
      case "verb":
        return "Động từ";
      case "adj":
        return "Tính từ";
      case "adv":
        return "Trạng từ";
      default:
        return "Chưa phân loại";
    }
  }
}

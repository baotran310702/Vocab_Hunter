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

  static String convertCustomAchievemntToString(
      CustomAchievement customAchievement) {
    return customAchievement.value.toString();
  }

  static CustomAchievement convertToCustomAchievement(dynamic value) {
    if (value is String) {
      return CustomAchievement.values
          .firstWhere((element) => element.value == value);
    } else if (value is int) {
      return CustomAchievement.values
          .firstWhere((element) => element.value == value.toString());
    } else {
      return CustomAchievement.trainRoom;
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

  static String convertAchievementType(AchievementType type) {
    switch (type) {
      case AchievementType.capyBathing:
        return AppIcons.capyBathing;
      case AchievementType.capyEating:
        return AppIcons.capyEating;
      case AchievementType.capySleeping:
        return AppIcons.capySleeping;
      case AchievementType.capyWritting:
        return AppIcons.capyWritting;
      case AchievementType.capyGraduate:
        return AppIcons.capyGraduate;
      case AchievementType.capyGraduate1:
        return AppIcons.capyGraduate1;
      case AchievementType.capyCow:
        return AppIcons.capyCow;
      case AchievementType.capyCoca:
        return AppIcons.capyCoca;
      case AchievementType.capyGuitar:
        return AppIcons.capyGuitar;
      case AchievementType.capyCooking:
        return AppIcons.capyCooking;
      case AchievementType.capyRabbit:
        return AppIcons.capyRabbit;
      case AchievementType.capyDoctor:
        return AppIcons.capyDoctor;
      default:
        return "";
    }
  }

  static AchievementType convertToAchievementType(int number) {
    switch (number) {
      case 1:
        return AchievementType.capyBathing;
      case 2:
        return AchievementType.capyEating;
      case 3:
        return AchievementType.capySleeping;
      case 4:
        return AchievementType.capyWritting;
      case 5:
        return AchievementType.capyGraduate;
      case 6:
        return AchievementType.capyGraduate1;
      case 7:
        return AchievementType.capyCow;
      case 8:
        return AchievementType.capyCoca;
      case 9:
        return AchievementType.capyGuitar;
      case 10:
        return AchievementType.capyCooking;
      case 11:
        return AchievementType.capyRabbit;
      case 12:
        return AchievementType.capyDoctor;
      default:
        throw Exception("Invalid number convert achievement: $number");
    }
  }

  static int convertAchievementTypeToIndex(AchievementType type) {
    switch (type) {
      case AchievementType.capyBathing:
        return 1;
      case AchievementType.capyEating:
        return 2;
      case AchievementType.capySleeping:
        return 3;
      case AchievementType.capyWritting:
        return 4;
      case AchievementType.capyGraduate:
        return 5;
      case AchievementType.capyGraduate1:
        return 6;
      case AchievementType.capyCow:
        return 7;
      case AchievementType.capyCoca:
        return 8;
      case AchievementType.capyGuitar:
        return 9;
      case AchievementType.capyCooking:
        return 10;
      case AchievementType.capyRabbit:
        return 11;
      case AchievementType.capyDoctor:
        return 12;
      default:
        return -1; // Hoặc giá trị nào đó để biểu thị lỗi
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

import 'package:english_learner/utils/enum.dart';
import 'package:english_learner/utils/icons.dart';
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

  static String convertAchievement(AchievementType type) {
    switch (type) {
      case AchievementType.bathingBoi:
        return AppIcons.bathingBoi;
      case AchievementType.eatingBoi:
        return AppIcons.eatingBoi;
      case AchievementType.sleepyBoi:
        return AppIcons.eatingBoi;
      case AchievementType.writingBoi:
        return AppIcons.writingBoi;
      default:
        return "";
    }
  }
}

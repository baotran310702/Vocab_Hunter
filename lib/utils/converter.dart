

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

static convertToMeanings(Map<String, List<String>> json){
  return {
    'adj':json['adj'],
    'verb':json['verb'],
    'adv':json['adv'],
    'noun':json['noun'],
    'default':json['noun'],
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
}
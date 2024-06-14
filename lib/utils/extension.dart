//declare extension extends from String

import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return "";
    trim();
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String startWithDot() {
    return "• $this";
  }

  String startWithExample() {
    if (isEmpty) return "";
    return "Example: $this";
  }

  bool isStartWith(String value) {
    String thisString =
        substring(0, value.length < length ? value.length : length);

    return thisString.toLowerCase().contains(value.toLowerCase());
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String toHourMinute() {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }
}

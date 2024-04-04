//declare extension extends from String

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return "";
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String startWithDot() {
    return "• $this";
  }

  String startWithExample() {
    return "Example: $this";
  }

  bool isStartWith(String value) {
    String thisString =
        substring(0, value.length < length ? value.length : length);

    return thisString.toLowerCase().contains(value.toLowerCase());
  }
}

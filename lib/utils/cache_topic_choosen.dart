class CacheTopicChoosen {
  static final _instance = CacheTopicChoosen._internal();

  factory CacheTopicChoosen() {
    return _instance;
  }

  CacheTopicChoosen._internal();

  static String topicId = "";

  void setTopicId(String topicId) {
    CacheTopicChoosen.topicId = topicId;
  }

  String getTopicId() {
    return CacheTopicChoosen.topicId;
  }
}

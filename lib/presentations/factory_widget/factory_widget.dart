import 'package:english_learner/utils/enum.dart';
import 'package:flutter/widgets.dart';

class FlashCardFactory {
  static Widget factoryWidget(FlashCardType type, {String? data}) {
    switch (type) {
      case FlashCardType.listVocabWidget:
        return const Text('Text Widget');
      case FlashCardType.topicWidget:
        return Image.network('https://picsum.photos/250?image=9');
      default:
        return const SizedBox();
    }
  }
}

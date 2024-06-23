import 'package:english_learner/models/vocabulary/vocab_topic.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';

class TupleVocab<T1, T2> {
  final VocabTopic? vocabTopic;
  final (VocabularyRemote, VocabularyRemote)? vocabRemote;
  const TupleVocab({this.vocabTopic, this.vocabRemote});
}

class SummarizeResult {
  final List<(TupleVocab, bool)> questionList;
  final String question;
  final String userAnswer;

  const SummarizeResult({
    required this.questionList,
    required this.question,
    required this.userAnswer,
  });

  SummarizeResult copyWith({
    List<(TupleVocab, bool)>? questionList,
    String? question,
    String? userAnswer,
  }) {
    return SummarizeResult(
      questionList: questionList ?? this.questionList,
      question: question ?? this.question,
      userAnswer: userAnswer ?? this.userAnswer,
    );
  }

  bool get isCorrect {
    for ((TupleVocab, bool) vocab in questionList) {
      if (vocab.$2 == true) {
        if (vocab.$1.vocabRemote != null &&
            vocab.$1.vocabRemote?.$1.word == userAnswer) {
          return true;
        }
        if (vocab.$1.vocabTopic != null &&
            vocab.$1.vocabTopic?.word == userAnswer) {
          return true;
        }
      }
    }
    return false;
  }

  String get correctAnswer {
    for ((TupleVocab, bool) vocab in questionList) {
      if (vocab.$2 == true) {
        if (vocab.$1.vocabRemote != null) {
          return vocab.$1.vocabRemote?.$1.word ?? "";
        }
        if (vocab.$1.vocabTopic != null) {
          return vocab.$1.vocabTopic?.word ?? "";
        }
      }
    }
    return "";
  }
}

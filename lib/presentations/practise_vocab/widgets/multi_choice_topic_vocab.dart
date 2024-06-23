import 'dart:math';

import 'package:english_learner/models/summarize_pratise.dart';
import 'package:english_learner/models/vocabulary/vocab_topic.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/extension.dart';
import 'package:flutter/material.dart';

class MultiChoiceTopicVocab extends StatefulWidget {
  final List<VocabTopic> questionList;
  final VocabTopic currentQuestion;
  final Function(bool, bool, SummarizeResult) onChangeNextQuestion;
  const MultiChoiceTopicVocab({
    super.key,
    required this.questionList,
    required this.currentQuestion,
    required this.onChangeNextQuestion,
  });

  @override
  State<MultiChoiceTopicVocab> createState() => _MultiChoiceTopicVocabState();
}

class _MultiChoiceTopicVocabState extends State<MultiChoiceTopicVocab> {
  @override
  Widget build(BuildContext context) {
    List<(VocabTopic, bool)> listAnswer =
        _createResultList(widget.questionList, widget.currentQuestion);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
              child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                const TextSpan(
                  text: 'What is the meaning of ',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: "${widget.currentQuestion.word}?",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          )),
        ),
        for (int i = 0; i < 4; i++)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 64,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.backgroundColorAchievement,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                int index = widget.questionList.indexWhere(
                    (element) => element.word == widget.currentQuestion.word);

                bool isEnd = index == widget.questionList.length - 1;
                List<(TupleVocab, bool)> listCurrentQuestion = [];
                for ((VocabTopic, bool) item in listAnswer) {
                  TupleVocab tupleVocab = TupleVocab(
                    vocabTopic: item.$1,
                  );
                  listCurrentQuestion.add((tupleVocab, item.$2));
                }

                SummarizeResult sumResult = SummarizeResult(
                  question:
                      "What is the meaning of ${widget.currentQuestion.word}?",
                  questionList: listCurrentQuestion,
                  userAnswer: listAnswer[i].$1.word,
                );
                widget.onChangeNextQuestion(
                    listAnswer[i].$1.word == widget.currentQuestion.word,
                    isEnd,
                    sumResult);
              },
              child: Text(
                listAnswer[i].$1.meaning.capitalize(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  _createResultList(List<VocabTopic> vocabList, VocabTopic currentQuestion) {
    List<(VocabTopic, bool)> listAnswer = [];
    List<int> listIndex = [];
    while (listAnswer.length < 3) {
      int randomIndex = Random().nextInt(vocabList.length);
      String currentWords = vocabList[randomIndex].word;

      if (listIndex.contains(randomIndex)) {
        continue;
      }

      for (var item in listAnswer) {
        if (item.$1.word.toLowerCase() == currentWords.toLowerCase()) {
          continue;
        }
      }

      if (vocabList[randomIndex].word != currentQuestion.word) {
        listAnswer.add((vocabList[randomIndex], false));
        listIndex.add(randomIndex);
      }
    }
    listAnswer.add((currentQuestion, true));
    listAnswer.shuffle();
    return listAnswer;
  }
}

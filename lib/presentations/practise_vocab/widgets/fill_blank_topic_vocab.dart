import 'dart:math';

import 'package:english_learner/models/summarize_pratise.dart';
import 'package:english_learner/models/vocabulary/vocab_topic.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/extension.dart';
import 'package:flutter/material.dart';

class FillBlankTopicVocabQuesiton extends StatefulWidget {
  final List<VocabTopic> questionTopicVocabList;
  final VocabTopic currentTopicVocabQuestion;

  final Function(bool, bool, SummarizeResult) onChangeNextTopicVocabQuestion;
  const FillBlankTopicVocabQuesiton({
    super.key,
    required this.questionTopicVocabList,
    required this.currentTopicVocabQuestion,
    required this.onChangeNextTopicVocabQuestion,
  });

  @override
  State<FillBlankTopicVocabQuesiton> createState() =>
      _FillBlankTopicVocabQuesitonState();
}

class _FillBlankTopicVocabQuesitonState
    extends State<FillBlankTopicVocabQuesiton> {
  @override
  Widget build(BuildContext context) {
    List<(VocabTopic, bool)> listAnswer = _createResultList(
        widget.questionTopicVocabList, widget.currentTopicVocabQuestion);

    (String, String) splitedSentences = splitSentences(
      widget.currentTopicVocabQuestion.exampleEnglish,
      widget.currentTopicVocabQuestion.word,
    );

    String questionSentences =
        "${splitedSentences.$1}${splitedSentences.$2 == "" ? "" : "_____"}${splitedSentences.$2.contains(".") ? splitedSentences.$2 : "${splitedSentences.$2}."}";

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              splitedSentences.$2 == ""
                  ? const Text(
                      "Choose the word that most relatived.",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : const Text(
                      "Fill the blank with the right word!",
                      style: TextStyle(fontSize: 20),
                    ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: splitedSentences.$1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    splitedSentences.$2 == ""
                        ? const TextSpan(
                            text: "",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          )
                        : const TextSpan(
                            text: "______",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                    TextSpan(
                      text: splitedSentences.$2.contains(".")
                          ? splitedSentences.$2
                          : "${splitedSentences.$2}.",
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
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
                int index = widget.questionTopicVocabList.indexWhere(
                    (element) =>
                        element.word == widget.currentTopicVocabQuestion.word);

                bool isEnd = index == widget.questionTopicVocabList.length - 1;

                List<(TupleVocab, bool)> listCurrentQuestion = [];
                for ((VocabTopic, bool) item in listAnswer) {
                  TupleVocab tupleVocab = TupleVocab(
                    vocabTopic: item.$1,
                  );
                  listCurrentQuestion.add((tupleVocab, item.$2));
                }

                SummarizeResult sumResult = SummarizeResult(
                    questionList: listCurrentQuestion,
                    question: questionSentences,
                    userAnswer: listAnswer[i].$1.word);
                widget.onChangeNextTopicVocabQuestion(
                  listAnswer[i].$1.word ==
                      widget.currentTopicVocabQuestion.word,
                  isEnd,
                  sumResult,
                );
              },
              child: Text(
                listAnswer[i].$1.word.capitalize(),
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

  (String, String) splitSentences(String currentSentence, String word) {
    String lowerCaseSentences = currentSentence.toLowerCase();
    String lowerCaseWord = word.toLowerCase();
    int index = lowerCaseSentences.indexOf(lowerCaseWord);
    if (index == -1) {
      return (currentSentence, "");
    }
    return (
      currentSentence.substring(0, index),
      currentSentence.substring(index + lowerCaseWord.length)
    );
  }
}

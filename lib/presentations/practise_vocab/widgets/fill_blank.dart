import 'dart:math';

import 'package:english_learner/models/summarize_pratise.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/extension.dart';
import 'package:flutter/material.dart';

import '../../../models/vocabulary/vocabulary_remote.dart';

class FillBlankQuesiton extends StatefulWidget {
  final List<(VocabularyRemote, VocabularyRemote)> questionList;
  final (VocabularyRemote, VocabularyRemote) currentQuestion;
  final String currentSentences;
  final Function(bool, bool, SummarizeResult) onChangeNextQuestion;
  const FillBlankQuesiton({
    super.key,
    required this.questionList,
    required this.currentSentences,
    required this.currentQuestion,
    required this.onChangeNextQuestion,
  });

  @override
  State<FillBlankQuesiton> createState() => _FillBlankQuesitonState();
}

class _FillBlankQuesitonState extends State<FillBlankQuesiton> {
  @override
  Widget build(BuildContext context) {
    List<((VocabularyRemote, VocabularyRemote), bool)> listAnswer =
        _createResultList(widget.questionList, widget.currentQuestion);

    (String, String) splitedSentences = splitSentences(
      widget.currentSentences,
      widget.currentQuestion.$1.word ?? "",
    );

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
              const Text(
                "Fill the blank with the right word!",
                style: TextStyle(fontSize: 18),
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
                    const TextSpan(
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
                int index = widget.questionList.indexWhere((element) =>
                    element.$1.word == widget.currentQuestion.$1.word);

                bool isEnd = index == widget.questionList.length - 1;

                List<(TupleVocab, bool)> listCurrentQuestion = [];

                for (((VocabularyRemote, VocabularyRemote), bool) item
                    in listAnswer) {
                  TupleVocab tupleVocab = TupleVocab(
                    vocabRemote: item.$1,
                  );
                  listCurrentQuestion.add((tupleVocab, item.$2));
                }

                SummarizeResult sumResult = SummarizeResult(
                    questionList: listCurrentQuestion,
                    userAnswer: listAnswer[i].$1.$2.word ?? "");
                widget.onChangeNextQuestion(
                  listAnswer[i].$1.$1.word == widget.currentQuestion.$1.word,
                  isEnd,
                  sumResult,
                );
              },
              child: Text(
                listAnswer[i].$1.$1.word?.capitalize() ?? "",
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

  _createResultList(List<(VocabularyRemote, VocabularyRemote)> vocabList,
      (VocabularyRemote, VocabularyRemote) currentQuestion) {
    List<((VocabularyRemote, VocabularyRemote), bool)> listAnswer = [];
    List<int> listIndex = [];
    while (listAnswer.length < 3) {
      int randomIndex = Random().nextInt(vocabList.length);
      String currentWords = vocabList[randomIndex].$2.word ?? "";

      if (listIndex.contains(randomIndex)) {
        continue;
      }

      for (var item in listAnswer) {
        if (item.$1.$2.word?.toLowerCase() == currentWords.toLowerCase()) {
          continue;
        }
      }

      if (vocabList[randomIndex].$1.word != currentQuestion.$1.word) {
        listAnswer.add(
            ((vocabList[randomIndex].$1, vocabList[randomIndex].$2), false));
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
    return (
      currentSentence.substring(0, index),
      currentSentence.substring(index + lowerCaseWord.length)
    );
  }
}

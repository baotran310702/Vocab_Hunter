import 'dart:math';

import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/extension.dart';
import 'package:flutter/material.dart';

class MultiChoiceVocab extends StatefulWidget {
  final List<(VocabularyRemote, VocabularyRemote)> questionList;
  final (VocabularyRemote, VocabularyRemote) currentQuestion;
  final Function(bool) onChangeNextQuestion;
  const MultiChoiceVocab({
    super.key,
    required this.questionList,
    required this.currentQuestion,
    required this.onChangeNextQuestion,
  });

  @override
  State<MultiChoiceVocab> createState() => _MultiChoiceVocabState();
}

class _MultiChoiceVocabState extends State<MultiChoiceVocab> {
  @override
  Widget build(BuildContext context) {
    List<((VocabularyRemote, VocabularyRemote), bool)> listAnswer =
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
                  text: "${widget.currentQuestion.$1.word ?? ""}?",
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
                widget.onChangeNextQuestion(
                    listAnswer[i].$1.$1.word == widget.currentQuestion.$1.word);
              },
              child: Text(
                listAnswer[i].$1.$2.word?.capitalize() ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
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
}

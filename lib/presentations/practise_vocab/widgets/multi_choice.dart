import 'dart:math';

import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class MultiChoiceVocab extends StatefulWidget {
  final List<VocabularyRemote> questionList;
  final VocabularyRemote currentQuestion;
  const MultiChoiceVocab({
    super.key,
    required this.questionList,
    required this.currentQuestion,
  });

  @override
  State<MultiChoiceVocab> createState() => _MultiChoiceVocabState();
}

class _MultiChoiceVocabState extends State<MultiChoiceVocab> {
  @override
  Widget build(BuildContext context) {
    List<(VocabularyRemote, bool)> listAnswer =
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
                  text: "${widget.currentQuestion.word ?? ""}?",
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
                debugPrint(listAnswer[i].$2.toString());
              },
              child: Text(
                listAnswer[i]
                        .$1
                        .meanings
                        ?.first
                        .definitions
                        ?.first
                        .definition ??
                    "",
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

  _createResultList(
      List<VocabularyRemote> vocabList, VocabularyRemote currentQuestion) {
    List<(VocabularyRemote, bool)> listAnswer = [];
    while (listAnswer.length < 3) {
      int randomIndex = Random().nextInt(vocabList.length);
      if (vocabList[randomIndex].word != currentQuestion.word) {
        listAnswer.add((vocabList[randomIndex], false));
      }
    }
    listAnswer.add((currentQuestion, true));
    listAnswer.shuffle();
    return listAnswer;
  }
}

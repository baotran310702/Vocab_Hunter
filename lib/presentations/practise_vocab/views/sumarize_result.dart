import 'package:english_learner/models/summarize_pratise.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

class SummarizePage extends StatefulWidget {
  final List<TupleVocab> questionList;
  final List<TupleVocab> correctAnswerList;
  final List<TupleVocab> failedAnswerList;
  final List<SummarizeResult> summarizeResults;

  const SummarizePage({
    super.key,
    required this.questionList,
    required this.correctAnswerList,
    required this.failedAnswerList,
    required this.summarizeResults,
  });

  @override
  State<SummarizePage> createState() => _SummarizePageState();
}

class _SummarizePageState extends State<SummarizePage> {
  @override
  Widget build(BuildContext context) {
    bool isActive =
        widget.correctAnswerList.length > widget.questionList.length / 2;

    String accompanish = isActive ? "Congratulations!" : "FAILED!";
    String advice =
        isActive ? "Your result is incredable!" : "You need to try again!";

    TextStyle titleStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            accompanish,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            advice,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isActive
                  ? Stack(
                      children: [
                        Image.asset(
                          AppIcons.capyDoctor,
                          width: 200,
                          height: 200,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Image.asset(
                            AppIcons.congrasAnimation,
                            width: 60,
                            height: 60,
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        Image.asset(
                          AppIcons.capyWritting,
                          width: 200,
                          height: 200,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Image.asset(
                            AppIcons.sad,
                            width: 60,
                            height: 60,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Correct Answer: ${widget.correctAnswerList.length}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "Failed Answer: ${widget.failedAnswerList.length}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),

          ///Show which words are wrong and correct
          const SizedBox(height: 20),
          const Text(
            "Your result:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 2,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    "No.",
                    textAlign: TextAlign.center,
                    style: titleStyle,
                  )),
              Expanded(
                  flex: 4,
                  child: Text(
                    "Question",
                    textAlign: TextAlign.center,
                    style: titleStyle,
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    "Your answer",
                    textAlign: TextAlign.center,
                    style: titleStyle,
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    "Correct answer",
                    textAlign: TextAlign.center,
                    style: titleStyle,
                  )),
            ],
          ),

          ///Devider line
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 2,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          ),

          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.summarizeResults.length,
              itemBuilder: (context, index) {
                String exampleEnglish = widget.summarizeResults[index].question;

                String correctAnswer =
                    widget.summarizeResults[index].correctAnswer;

                String yourAnswer = widget.summarizeResults[index].userAnswer;
                bool isCorrect = widget.summarizeResults[index].isCorrect;
                return Column(
                  children: [
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              index.toString(),
                              style: TextStyle(
                                color: isCorrect ? Colors.green : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            flex: 4,
                            child: Text(
                              exampleEnglish,
                              style: TextStyle(
                                color: isCorrect ? Colors.green : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            flex: 3,
                            child: Text(
                              yourAnswer,
                              style: TextStyle(
                                color: isCorrect ? Colors.green : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            flex: 3,
                            child: Text(
                              correctAnswer,
                              style: TextStyle(
                                color: isCorrect ? Colors.green : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      height: 0.5,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

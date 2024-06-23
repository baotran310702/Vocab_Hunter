import 'package:english_learner/models/summarize_pratise.dart';
import 'package:english_learner/models/vocabulary/vocab_topic.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/global_instance/loading.dart';
import 'package:english_learner/presentations/practise_vocab/bloc/practise_vocab_bloc.dart';
import 'package:english_learner/presentations/practise_vocab/views/question_word_topic_vocab.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/progress.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:english_learner/utils/toasty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PractiseVocabTopic extends StatefulWidget {
  final String subTopicId;
  const PractiseVocabTopic({super.key, required this.subTopicId});

  @override
  State<PractiseVocabTopic> createState() => _PractiseVocabTopicState();
}

class _PractiseVocabTopicState extends State<PractiseVocabTopic> {
  @override
  Widget build(BuildContext context) {
    PractiseVocabBloc practiseVocabBloc = PractiseVocabBloc();
    return BlocProvider(
      create: (context) => practiseVocabBloc
        ..add(
          PractiseVocabTopicInitial(subTopicId: widget.subTopicId),
        ),
      child: PopScope(
        onPopInvoked: (canPop) {
          if (canPop) {
            Toasty.disposeAllToasty();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: MyAppbar(
            text: "Practise Room",
            onPressed: () {
              Toasty.disposeAllToasty();
              Navigator.pop(context);
            },
          ),
          body: BlocBuilder<PractiseVocabBloc, PractiseVocabState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const LoadingPage(message: "Loading, please wait...");
              }
              if (state is AnswerResult) {
                return SafeArea(
                  child: SummarizePage(
                    questionList: state.questionTopicVocabList,
                    correctAnswerList: state.correctAnswerTopicVocabList,
                    failedAnswerList: state.failedAnswerTopicVocabList,
                    summarizeResults: state.summarizeResult,
                  ),
                );
              } else {
                return state.questionTopicVocabList.isEmpty
                    ? const LoadingPage(
                        message:
                            "Something went wrong with data, please remove data and download again!")
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: practiseContent(state, context),
                      );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget practiseContent(PractiseVocabState state, BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        QuestionVocabTopic(),
        ProgressBar(
          isTopicVocab: true,
        ),
      ],
    );
  }
}

class SummarizePage extends StatefulWidget {
  final List<VocabTopic> questionList;
  final List<VocabTopic> correctAnswerList;
  final List<VocabTopic> failedAnswerList;
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
    List<(bool, VocabTopic)> resultList = [];
    for (int i = 0; i < widget.questionList.length; i++) {
      if (widget.correctAnswerList.contains(widget.questionList[i])) {
        resultList.add((true, widget.questionList[i]));
      } else {
        resultList.add((false, widget.questionList[i]));
      }
    }

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
                String exampleEnglish = widget
                    .summarizeResults[index].questionList
                    .firstWhere((element) => element.$2 == true)
                    .$1
                    .vocabTopic!
                    .exampleEnglish;
                String correctAnswer = widget
                    .summarizeResults[index].questionList
                    .firstWhere((element) => element.$2 == true)
                    .$1
                    .vocabTopic!
                    .word;

                String yourAnswer = widget.summarizeResults[index].userAnswer;
                bool isCorrect = correctAnswer.trim().toLowerCase() ==
                    yourAnswer.trim().toLowerCase();
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

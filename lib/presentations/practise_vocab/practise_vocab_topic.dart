import 'package:english_learner/models/vocabulary/vocab_topic.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
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

  const SummarizePage({
    super.key,
    required this.questionList,
    required this.correctAnswerList,
    required this.failedAnswerList,
  });

  @override
  State<SummarizePage> createState() => _SummarizePageState();
}

class _SummarizePageState extends State<SummarizePage> {
  @override
  Widget build(BuildContext context) {
    bool isActive =
        widget.correctAnswerList.length > widget.questionList.length / 2;
    String accompanish = isActive
        ? "Congratulations, your result is incredable!"
        : "It looks like you have to try harder next time!";
    List<(bool, VocabTopic)> resultList = [];
    for (int i = 0; i < widget.questionList.length; i++) {
      if (widget.correctAnswerList.contains(widget.questionList[i])) {
        resultList.add((true, widget.questionList[i]));
      } else {
        resultList.add((false, widget.questionList[i]));
      }
    }
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                Image.asset(
                  isActive ? AppIcons.capyDoctor : AppIcons.capyWritting,
                  width: 200,
                  height: 200,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    isActive ? AppIcons.congrasAnimation : AppIcons.sad,
                    width: 100,
                    height: 100,
                  ),
                ),
              ]),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Correct Answer: ${widget.correctAnswerList.length}",
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Text(
            "Failed Answer: ${widget.failedAnswerList.length}",
            style: const TextStyle(fontSize: 20),
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
          const Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "Number",
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                  flex: 5,
                  child: Text(
                    "Question",
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    "Your answer",
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    "Correct answer",
                    textAlign: TextAlign.center,
                  )),
            ],
          ),

          ///Show which words are wrong and correct
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 4),
                    //TODO: lam tiep chjuc nang hien thi ket qua
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              index.toString(),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            flex: 5,
                            child: Text(
                              resultList[index].$2.exampleEnglish,
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Your answer",
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            flex: 3,
                            child: Text(
                              "Correct answer",
                              textAlign: TextAlign.center,
                            )),
                      ],
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

import 'package:english_learner/models/summarize_pratise.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/global_instance/loading.dart';
import 'package:english_learner/presentations/practise_vocab/bloc/practise_vocab_bloc.dart';
import 'package:english_learner/presentations/practise_vocab/views/question_word_topic_vocab.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/progress.dart';
import 'package:english_learner/utils/toasty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'views/sumarize_result.dart';

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
                List<TupleVocab> questionList = state.questionTopicVocabList
                    .map((e) => TupleVocab(vocabTopic: e))
                    .toList();
                List<TupleVocab> failedAnswerList = state
                    .failedAnswerTopicVocabList
                    .map((e) => TupleVocab(vocabTopic: e))
                    .toList();

                List<TupleVocab> correctAnswerList = state
                    .correctAnswerTopicVocabList
                    .map((e) => TupleVocab(vocabTopic: e))
                    .toList();
                return SafeArea(
                  child: SummarizePage(
                    questionList: questionList,
                    correctAnswerList: correctAnswerList,
                    failedAnswerList: failedAnswerList,
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

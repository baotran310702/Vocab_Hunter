import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/global_instance/loading.dart';
import 'package:english_learner/presentations/practise_vocab/bloc/practise_vocab_bloc.dart';
import 'package:english_learner/presentations/practise_vocab/views/question_word.dart';
import 'package:english_learner/presentations/practise_vocab/views/question_word_topic_vocab.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/progress.dart';
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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const MyAppbar(text: "Practise Room"),
        body: BlocBuilder<PractiseVocabBloc, PractiseVocabState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const LoadingPage(message: "Loading, please wait...");
            }
            if (state is AnswerResult) {
              return SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Correct Answer: ${state.correctAnswerList.length}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Failed Answer: ${state.failedAnswerList.length}",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
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

import 'package:english_learner/models/vocabulary_topic/vocabulary_topic.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/global_instance/loading.dart';
import 'package:english_learner/presentations/practise_vocab/bloc/practise_vocab_bloc.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/custom_drop_down.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/progress.dart';
import 'package:english_learner/presentations/practise_vocab/views/question_word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PractiseVocab extends StatefulWidget {
  final List<VocabularyByTopic>? vocabularies;
  const PractiseVocab({super.key, this.vocabularies});

  @override
  State<PractiseVocab> createState() => _PractiseVocabState();
}

class _PractiseVocabState extends State<PractiseVocab> {
  String currentLearningListName = "All";
  @override
  Widget build(BuildContext context) {
    PractiseVocabBloc practiseVocabBloc = PractiseVocabBloc();
    return BlocProvider(
      create: (context) => practiseVocabBloc..add(PractiseVocabInitial()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const MyAppbar(text: "Practise Room"),
        body: BlocBuilder<PractiseVocabBloc, PractiseVocabState>(
          builder: (context, state) {
            List<String> currentLearningList = state.currentUser.learningWords
                .map((e) => e.listName.toString())
                .toList();
            currentLearningList.insert(0, "All");
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
              return SafeArea(
                child: Center(
                  child: practiseContent(currentLearningList, state, context),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Column practiseContent(List<String> currentLearningList,
      PractiseVocabState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomDropDown(
            listItem: currentLearningList,
            onChanged: (value) {
              if (value.toLowerCase() == "all") {
                context.read<PractiseVocabBloc>().add(
                      ChangeVocabList(
                        listId: "*",
                      ),
                    );
              }
              setState(() {
                currentLearningListName = value.toString();
              });
              for (int i = 0; i < state.currentUser.learningWords.length; i++) {
                if (state.currentUser.learningWords[i].listName.toLowerCase() ==
                    value.toLowerCase()) {
                  context.read<PractiseVocabBloc>().add(
                        ChangeVocabList(
                          listId: state.currentUser.learningWords[i].listId,
                        ),
                      );
                  return;
                }
              }
            }),
        const QuestionVocab(),
        const ProgressBar(),
      ],
    );
  }
}

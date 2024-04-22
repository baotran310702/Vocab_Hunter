import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/practise_vocab/bloc/practise_vocab_bloc.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/custom_drop_down.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/progress.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/question_word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PractiseVocab extends StatefulWidget {
  const PractiseVocab({super.key});

  @override
  State<PractiseVocab> createState() => _PractiseVocabState();
}

class _PractiseVocabState extends State<PractiseVocab> {
  String currentLearningListName = "All";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PractiseVocabBloc()..add(PractiseVocabInitial()),
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
              return const Center(child: CircularProgressIndicator());
            }
            return SafeArea(
              child: Center(
                child: Column(
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
                        for (int i = 0;
                            i < state.currentUser.learningWords.length;
                            i++) {
                          if (state.currentUser.learningWords[i].listName ==
                              value) {
                            context.read<PractiseVocabBloc>().add(
                                  ChangeVocabList(
                                    listId: state
                                        .currentUser.learningWords[i].listId,
                                  ),
                                );
                          }
                        }
                      },
                    ),
                    const QuestionVocab(),
                    const ProgressBar(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

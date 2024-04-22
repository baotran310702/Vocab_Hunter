import 'package:english_learner/presentations/practise_vocab/bloc/practise_vocab_bloc.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/multi_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionVocab extends StatefulWidget {
  const QuestionVocab({super.key});

  @override
  State<QuestionVocab> createState() => _QuestionVocabState();
}

class _QuestionVocabState extends State<QuestionVocab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PractiseVocabBloc, PractiseVocabState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.questionList.isNotEmpty) {
          return MultiChoiceVocab(
            currentQuestion: state.questionList[state.currentQuestionIndex],
            questionList: state.questionList,
          );
        }
        return const SizedBox();
      },
    );
  }
}

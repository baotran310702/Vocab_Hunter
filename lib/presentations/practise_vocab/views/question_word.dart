import 'package:english_learner/presentations/global_instance/loading.dart';
import 'package:english_learner/presentations/practise_vocab/bloc/practise_vocab_bloc.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/fill_blank.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/multi_choice.dart';
import 'package:english_learner/utils/toasty.dart';
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

        if (state.questionList.isEmpty) {
          return const LoadingPage(message: "Loadinggg");
          // return const Center(
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 20),
          //     child: Text(
          //       "No question available, this list may have no words to practise.",
          //       style: TextStyle(
          //         fontSize: 19,
          //         fontWeight: FontWeight.w300,
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // );
        }

        if (state.questionList.isNotEmpty) {
          if (state.currentQuestionIndex < state.questionList.length &&
              state.sentences.containsKey(
                  state.questionList[state.currentQuestionIndex].$1.word)) {
            return FillBlankQuesiton(
              currentQuestion: state.questionList[state.currentQuestionIndex],
              questionList: state.questionList,
              currentSentences: state.sentences[
                      state.questionList[state.currentQuestionIndex].$1.word] ??
                  "",
              onChangeNextQuestion: _onChangeNextQuestion,
            );
          }

          return MultiChoiceVocab(
            currentQuestion: state.questionList[state.currentQuestionIndex],
            questionList: state.questionList,
            onChangeNextQuestion: _onChangeNextQuestion,
          );
        }
        return const SizedBox();
      },
    );
  }

  _onChangeNextQuestion(bool isTrue, bool isEnd) {
    if (isTrue) {
      Toasty.showToastCorner(msg: "Correct!", context: context);
    } else {
      Toasty.showToastCorner(msg: "Incorrect!", context: context);
    }
    if (isEnd) {
      Toasty.disposeAllToasty();
    }

    context.read<PractiseVocabBloc>().add(ChangeNextQuestion(isTrue: isTrue));
  }
}

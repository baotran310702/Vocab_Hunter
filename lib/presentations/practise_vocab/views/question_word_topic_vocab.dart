import 'package:english_learner/models/summarize_pratise.dart';
import 'package:english_learner/presentations/global_instance/loading.dart';
import 'package:english_learner/presentations/practise_vocab/bloc/practise_vocab_bloc.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/fill_blank_topic_vocab.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/multi_choice_topic_vocab.dart';
import 'package:english_learner/presentations/user_profile/bloc/manage_user_bloc.dart';
import 'package:english_learner/utils/enum.dart';
import 'package:english_learner/utils/toasty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionVocabTopic extends StatefulWidget {
  const QuestionVocabTopic({super.key});

  @override
  State<QuestionVocabTopic> createState() => _QuestionVocabTopicState();
}

class _QuestionVocabTopicState extends State<QuestionVocabTopic> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PractiseVocabBloc, PractiseVocabState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingPage(message: "Loading...");
        }

        if (state.questionTopicVocabList.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "No question available, this list may have no words to practise.",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (state.questionTopicVocabList.isNotEmpty) {
          if (state.currentQuestionIndex <
                  state.questionTopicVocabList.length &&
              state.sentences.containsKey(state
                  .questionTopicVocabList[state.currentQuestionIndex].word)) {
            return FillBlankTopicVocabQuesiton(
              currentTopicVocabQuestion:
                  state.questionTopicVocabList[state.currentQuestionIndex],
              questionTopicVocabList: state.questionTopicVocabList,
              onChangeNextTopicVocabQuestion: _onChangeNextQuestion,
            );
          }

          return MultiChoiceTopicVocab(
            currentQuestion:
                state.questionTopicVocabList[state.currentQuestionIndex],
            questionList: state.questionTopicVocabList,
            onChangeNextQuestion: _onChangeNextQuestion,
          );
        }
        return const SizedBox();
      },
    );
  }

  _onChangeNextQuestion(
      bool isTrue, bool isEnd, SummarizeResult currentQuestion) {
    if (isTrue) {
      context.read<ManageUserProfileBloc>().add(
            UpdateAchievementEvent(
              customAchievement: CustomAchievement.vocab,
              isEnd: false,
            ),
          );
      Toasty.showToastCorner(msg: "Correct!", context: context);
    } else {
      Toasty.showToastCorner(msg: "Incorrect!", context: context);
    }
    if (isEnd) {
      context.read<ManageUserProfileBloc>().add(
            UpdateAchievementEvent(
              customAchievement: CustomAchievement.trainRoom,
              isEnd: true,
            ),
          );
      Toasty.disposeAllToasty();
    }

    context.read<PractiseVocabBloc>().add(
          ChangeNextQuestionTopicVocab(
            isTrue: isTrue,
            currentQuestion: currentQuestion,
          ),
        );
  }
}

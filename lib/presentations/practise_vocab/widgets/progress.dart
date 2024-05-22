import 'package:english_learner/presentations/practise_vocab/bloc/practise_vocab_bloc.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PractiseVocabBloc, PractiseVocabState>(
      builder: (context, state) {
        double leftPercent = state.questionList.isNotEmpty
            ? state.currentQuestionIndex / (state.questionList.length - 1)
            : 0;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          height: 80,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              Text(
                "Progress: ${state.currentQuestionIndex}/${(state.questionList.length - 1)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                height: 12,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: AppColors.backgroundAppbar,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.borderInput,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 18,
                          width: MediaQuery.of(context).size.width *
                              0.8 *
                              leftPercent,
                        ),
                        Container(
                          height: 18,
                          width: MediaQuery.of(context).size.width *
                              0.8 *
                              (1 - leftPercent),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

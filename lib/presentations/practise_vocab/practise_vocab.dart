import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/multi_choice.dart';
import 'package:english_learner/presentations/practise_vocab/widgets/progress.dart';
import 'package:flutter/material.dart';

class PractiseVocab extends StatefulWidget {
  const PractiseVocab({super.key});

  @override
  State<PractiseVocab> createState() => _PractiseVocabState();
}

class _PractiseVocabState extends State<PractiseVocab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppbar(text: "Practise Room"),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MultiChoiceVocab(),
              ProgressBar(),
            ],
          ),
        ),
      ),
    );
  }
}

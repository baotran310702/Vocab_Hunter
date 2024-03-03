import 'package:english_learner/presentations/user_vocabulary_training/bloc/manage_vocab_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlashCardVocabulary extends StatefulWidget {
  const FlashCardVocabulary({super.key});

  @override
  State<FlashCardVocabulary> createState() => FlashCardVocabularyState();
}

class FlashCardVocabularyState extends State<FlashCardVocabulary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ManageVocabBloc, ManageVocabState>(
          builder: (context, state) {
            return Column(
              children:  [
                Text(state.meaningRecommendVocabs),
              ],
            );
          },
        ),
      ),
    );
  }
}

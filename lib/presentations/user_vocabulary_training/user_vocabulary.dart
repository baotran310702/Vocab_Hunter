import 'package:english_learner/presentations/user_vocabulary_training/bloc/manage_vocab_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserVocabulary extends StatelessWidget {
  const UserVocabulary({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController vocabInputController = TextEditingController();
    return SafeArea(
      child: BlocBuilder<ManageVocabBloc, ManageVocabState>(
        builder: (context, state) {
          return Column(
            children: [
              TextFormField(
                controller: vocabInputController,
                decoration: const InputDecoration(
                  labelText: 'Enter Vocabulary',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<ManageVocabBloc>().add(
                      LoadVocabEvent(inputVocab: vocabInputController.text));
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }
}

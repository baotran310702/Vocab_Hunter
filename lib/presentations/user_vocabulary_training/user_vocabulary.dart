import 'package:english_learner/presentations/user_vocabulary_training/bloc/manage_vocab_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                  if (vocabInputController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Please enter vocabulary!',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  context.read<ManageVocabBloc>().add(GetSimilarityVocabEvent(
                      inputVocab: vocabInputController.text));
                },
                child: const Text('Add'),
              ),

              ElevatedButton(
                onPressed: () {
                  if (vocabInputController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Please enter vocabulary!',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  context.read<ManageVocabBloc>().add(
                        GetSimilarVocabModel(
                            inputVocab: vocabInputController.text),
                      );
                },
                child: const Text('Get Data From Local Model'),
              ),
              //ListView to show state.list
              state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        itemCount: state.similarVocabs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              context.read<ManageVocabBloc>().add(
                                  GetMeaningVocab(
                                      inputVocab:
                                          state.similarVocabs[index].word));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Container()));
                            },
                            child: ListTile(
                              title: Text(state.similarVocabs[index].word),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {},
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}

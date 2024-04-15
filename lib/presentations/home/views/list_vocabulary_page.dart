import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/home/widgets/vocabulary_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../user_vocabulary/bloc/manage_vocab_bloc.dart';

class ListVocabularyItem extends StatefulWidget {
  const ListVocabularyItem({super.key});

  @override
  State<ListVocabularyItem> createState() => _ListVocabularyItemState();
}

class _ListVocabularyItemState extends State<ListVocabularyItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageVocabBloc, ManageVocabState>(
      builder: (context, state) {
        String nameTopic = state.userModel.learningWords
            .where((element) => element.listId == state.currentDefaultListId)
            .first
            .listName;
        List<UserVocab> listVocab = state.userModel.learningWords
            .where((element) => element.listId == state.currentDefaultListId)
            .toList();
        return Scaffold(
          appBar: MyAppbar(
            text: nameTopic.toUpperCase(),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: listVocab[0].listVocabulary.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          VocabularyItem(
                            vocab: listVocab[0].listVocabulary[index],
                          ),
                          Container(
                            color: Colors.black,
                            height: 1,
                            width: MediaQuery.of(context).size.width * 0.9,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/home/widgets/vocabulary_item.dart';
import 'package:flutter/material.dart';

class ListVocabularyItem extends StatefulWidget {
  final UserVocab currentVocabList;

  const ListVocabularyItem({super.key, required this.currentVocabList});

  @override
  State<ListVocabularyItem> createState() => _ListVocabularyItemState();
}

class _ListVocabularyItemState extends State<ListVocabularyItem> {
  @override
  Widget build(BuildContext context) {
    List<VocabularyRemote> currentVocabList =
        widget.currentVocabList.listVocabulary.entries.first.value;

    return Scaffold(
      appBar: MyAppbar(
        text: widget.currentVocabList.listName.toUpperCase(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: currentVocabList
                .map((e) => Column(
                      children: [
                        VocabularyItem(
                          vocab: e,
                        ),
                        Container(
                          color: Colors.black,
                          height: 1,
                          width: MediaQuery.of(context).size.width * 0.9,
                        )
                      ],
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

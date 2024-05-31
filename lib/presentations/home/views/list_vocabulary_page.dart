import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/models/vocabulary/vocab_translated_local.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/home/widgets/vocabulary_item.dart';
import 'package:flutter/material.dart';

import '../../dictionary_page/views/detail_vocabulary.dart';

class ListVocabularyItem extends StatefulWidget {
  final UserVocab currentVocabList;

  const ListVocabularyItem({super.key, required this.currentVocabList});

  @override
  State<ListVocabularyItem> createState() => _ListVocabularyItemState();
}

class _ListVocabularyItemState extends State<ListVocabularyItem> {
  @override
  Widget build(BuildContext context) {
    List<VocabularyRemote> currentVocabEnglishList =
        widget.currentVocabList.listVocabulary.isEmpty
            ? []
            : widget.currentVocabList.listVocabulary.entries.first.value;

    return Scaffold(
      appBar: MyAppbar(
        text: widget.currentVocabList.listName.toUpperCase(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            for (int i = 0; i < currentVocabEnglishList.length; i++)
              Column(
                children: [
                  VocabularyItem(
                    vocab: currentVocabEnglishList[i],
                    onTap: () => _onTapVocabItem(
                      context,
                      VocabTranslatedLocalModel(
                        englishWords: currentVocabEnglishList[i],
                        vietnameseWords: widget.currentVocabList.listVocabulary
                            .entries.last.value[i],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black54,
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.9,
                  )
                ],
              ),
          ]),
        ),
      ),
    );
  }

  void _onTapVocabItem(BuildContext context, VocabTranslatedLocalModel vocab) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailVocabulary(
          vocabTranslatedLocal: vocab,
        ),
      ),
    );
  }
}

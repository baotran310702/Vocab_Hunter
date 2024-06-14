import 'package:english_learner/models/vocabulary/vocab_topic.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/presentations/dictionary_page/widgets/pronounce_word.dart';
import 'package:flutter/material.dart';

class VocabularyItem extends StatefulWidget {
  final VocabularyRemote? vocab;
  final VocabTopic? vocabularyByTopic;
  final Function onTap;
  const VocabularyItem({
    super.key,
    this.vocab,
    this.vocabularyByTopic,
    required this.onTap,
  });

  @override
  State<VocabularyItem> createState() => _VocabularyItemState();
}

class _VocabularyItemState extends State<VocabularyItem> {
  @override
  Widget build(BuildContext context) {
    VocabularyItemList itemVocab = VocabularyItemList(
        word: widget.vocab?.word ?? widget.vocabularyByTopic?.word ?? "",
        pronouce:
            widget.vocab?.phonetic ?? widget.vocabularyByTopic?.pronounce ?? "",
        meaning: widget.vocab?.meanings?.first.definitions?.first.definition ??
            widget.vocabularyByTopic?.meaning ??
            "");

    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildWord(itemVocab),
                    buildPhonetics(itemVocab),
                    buildMeanings(context, itemVocab),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [PronounceWord(word: itemVocab.word)],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text buildWord(VocabularyItemList itemVocab) {
    return Text(
      itemVocab.word,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildMeanings(BuildContext context, VocabularyItemList itemVocab) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Text(
        itemVocab.meaning,
        style: const TextStyle(
          fontSize: 14,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildPhonetics(VocabularyItemList itemVocab) {
    if (itemVocab.pronouce.trim() == "") {
      return const SizedBox();
    } else {
      return Text(
        itemVocab.pronouce,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
      );
    }
  }
}

class VocabularyItemList {
  final String word;
  final String pronouce;
  final String meaning;

  VocabularyItemList({
    required this.word,
    required this.pronouce,
    required this.meaning,
  });

  VocabularyItemList copyWith({
    String? word,
    String? pronouce,
    String? meaning,
  }) {
    return VocabularyItemList(
      word: word ?? this.word,
      pronouce: pronouce ?? this.pronouce,
      meaning: meaning ?? this.meaning,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'pronouce': pronouce,
      'meaning': meaning,
    };
  }

  factory VocabularyItemList.fromMap(Map<String, dynamic> map) {
    return VocabularyItemList(
      word: map['word'],
      pronouce: map['pronouce'],
      meaning: map['meaning'],
    );
  }
}

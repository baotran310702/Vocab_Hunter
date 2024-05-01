import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/presentations/dictionary_page/widgets/pronounce_word.dart';
import 'package:flutter/material.dart';

class VocabularyItem extends StatefulWidget {
  final VocabularyRemote vocab;
  final Function onTap;
  const VocabularyItem({super.key, required this.vocab, required this.onTap});

  @override
  State<VocabularyItem> createState() => _VocabularyItemState();
}

class _VocabularyItemState extends State<VocabularyItem> {
  @override
  Widget build(BuildContext context) {
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
                    buildWord(),
                    buildPhonetics(),
                    buildMeanings(context),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [PronounceWord(word: widget.vocab.word ?? "")],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text buildWord() {
    return Text(
      widget.vocab.word ?? "",
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildMeanings(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Text(
        widget.vocab.meanings != null &&
                widget.vocab.meanings!.isNotEmpty &&
                widget.vocab.meanings![0].definitions != null &&
                widget.vocab.meanings![0].definitions!.isNotEmpty
            ? widget.vocab.meanings![0].definitions![0].definition ?? ""
            : "",
        style: const TextStyle(
          fontSize: 14,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildPhonetics() {
    if (widget.vocab.phonetics == null ||
        widget.vocab.phonetics!.isEmpty ||
        widget.vocab.phonetics![0].text == null) {
      return const SizedBox();
    } else {
      return Text(
        widget.vocab.phonetics![0].text!,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
      );
    }
  }
}

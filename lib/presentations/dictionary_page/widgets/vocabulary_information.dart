import 'package:english_learner/models/vocabulary.dart';
import 'package:english_learner/presentations/dictionary_page/widgets/pronounce_word.dart';
import 'package:flutter/material.dart';

class VocabularyInfor extends StatefulWidget {
  final Vocabulary vocabulary;
  const VocabularyInfor({super.key, required this.vocabulary});

  @override
  State<VocabularyInfor> createState() => _VocabularyInforState();
}

class _VocabularyInforState extends State<VocabularyInfor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.vocabulary.vocabId,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Flexible(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.blue[200],
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.vocabulary.pronunciation.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Text("/${widget.vocabulary.pronunciation[index]}/"),
                      const SizedBox(
                        width: 12,
                      ),
                      index == 0
                          ? PronounceWord(word: widget.vocabulary.vocabId)
                          : const SizedBox(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Flexible(
          child: Container(
            color: Colors.amber,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.vocabulary.meaning.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.vocabulary.meaning.keys.elementAt(index)),
                  subtitle: Text(widget.vocabulary.meaning.values
                      .elementAt(index)
                      .join(", ")),
                );
              },
            ),
          ),
        ),
        const Text(
          "Example",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Flexible(
          child: Container(
            color: Colors.pink[200],
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.vocabulary.example.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.vocabulary.example[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

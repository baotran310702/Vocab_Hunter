import 'package:english_learner/models/vocabulary/vocabulary.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:flutter/material.dart';

class DetailVocabLocal extends StatefulWidget {
  final Vocabulary vocabulary;
  const DetailVocabLocal({super.key, required this.vocabulary});

  @override
  State<DetailVocabLocal> createState() => _DetailVocabLocalState();
}

class _DetailVocabLocalState extends State<DetailVocabLocal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(text: widget.vocabulary.vocabId),
      body: SafeArea(
        child: Column(
          children: [
            Text(widget.vocabulary.vocabId),
          ],
        ),
      ),
    );
  }
}

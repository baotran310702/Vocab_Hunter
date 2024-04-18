import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:flutter/material.dart';

class PractiseVocab extends StatefulWidget {
  const PractiseVocab({super.key});

  @override
  State<PractiseVocab> createState() => _PractiseVocabState();
}

class _PractiseVocabState extends State<PractiseVocab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(text: "Practise Room"),
      body: SafeArea(
        child: Container(
            child: const Center(
          child: Text("Practise Vocab"),
        )),
      ),
    );
  }
}

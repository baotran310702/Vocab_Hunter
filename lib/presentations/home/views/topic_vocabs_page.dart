import 'package:english_learner/presentations/home/widgets/back_button.dart';
import 'package:english_learner/presentations/home/widgets/list_topics_vocab.dart';
import 'package:flutter/material.dart';

class TopicVocab extends StatelessWidget {
  const TopicVocab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topic Vocab'),
        leading: const ButtonBack(),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTopicVocab(),
              ListTopicVocab(),
              ListTopicVocab(),
              ListTopicVocab(),
              ListTopicVocab(),
              ListTopicVocab(),
            ],
          ),
        ),
      ),
    );
  }
}

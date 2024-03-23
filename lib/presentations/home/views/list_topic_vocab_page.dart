import 'package:english_learner/presentations/home/widgets/back_button.dart';
import 'package:flutter/material.dart';

import '../widgets/box_topic_detail.dart';

class ListDetailTopicVocab extends StatefulWidget {
  const ListDetailTopicVocab({super.key});

  @override
  State<ListDetailTopicVocab> createState() => _LisDetailtTopicVocabState();
}

class _LisDetailtTopicVocabState extends State<ListDetailTopicVocab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topic Vocab'),
        leading: const ButtonBack(),
      ),
      body: const PageContent(),
    );
  }
}

class PageContent extends StatelessWidget {
  const PageContent({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5, 6];

    double boxHeight = 360;
    double radius = 20;
    return Container(
      padding: const EdgeInsets.all(14),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color(0xffe0e0e0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: list
              .map((e) => BoxTopicDetail(
                    boxHeight: boxHeight,
                    radius: radius,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

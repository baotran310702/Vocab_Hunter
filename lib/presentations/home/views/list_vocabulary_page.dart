import 'package:english_learner/presentations/global_widgets/appbar.dart';
import 'package:english_learner/presentations/home/widgets/vocabulary_item.dart';
import 'package:flutter/material.dart';

class ListVocabularyItem extends StatelessWidget {
  const ListVocabularyItem({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> list = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10
    ];
    return Scaffold(
      appBar: const MyAppbar(
        text: "Topic A",
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const VocabularyItem(),
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
  }
}

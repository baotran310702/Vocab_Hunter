import 'package:english_learner/presentations/home/widgets/box_topic_item.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class ListTopicVocab extends StatefulWidget {
  const ListTopicVocab({super.key});

  @override
  State<ListTopicVocab> createState() => _ListTopicVocabState();
}

class _ListTopicVocabState extends State<ListTopicVocab> {
  List<int> list = List.generate(10, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Art",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColors,
                ),
              ),
              const Text(
                "See all",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: list.map((e) => const BoxTopicItem()).toList(),
            ),
          )
        ],
      ),
    );
  }
}

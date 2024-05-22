import 'package:english_learner/models/topic.dart';
import 'package:english_learner/presentations/home/widgets/box_topic_item.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class ListTopicVocab extends StatefulWidget {
  final Topic topic;
  const ListTopicVocab({super.key, required this.topic});

  @override
  State<ListTopicVocab> createState() => _ListTopicVocabState();
}

class _ListTopicVocabState extends State<ListTopicVocab> {
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
                widget.topic.name,
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
              children: widget.topic.subTopics
                  .map((e) => BoxTopicItem(
                        subTopic: e,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

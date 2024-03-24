import 'package:english_learner/gen/assets.gen.dart';
import 'package:english_learner/presentations/home/views/topic_vocabs_page.dart';
import 'package:english_learner/presentations/home/widgets/divider.dart';
import 'package:english_learner/presentations/home/widgets/item_type_vocab.dart';
import 'package:flutter/material.dart';

class ListVocabType extends StatelessWidget {
  const ListVocabType({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeIcon = 30;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Type of Vocab",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ItemTypeVocab(
                  text: "Flashcard",
                  icon: Assets.icons.flash_card
                      .image(width: sizeIcon, height: sizeIcon),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const TopicVocab(),
                      ),
                    );
                  },
                ),
                const Devider(),
                ItemTypeVocab(
                  text: "Topics",
                  icon: Assets.icons.topics
                      .image(width: sizeIcon, height: sizeIcon),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const TopicVocab(),
                      ),
                    );
                  },
                ),
                const Devider(),
                ItemTypeVocab(
                  text: "News",
                  icon: Assets.icons.news
                      .image(width: sizeIcon, height: sizeIcon),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const TopicVocab(),
                      ),
                    );
                  },
                ),
                const Devider(),
                ItemTypeVocab(
                  text: "Ielts - Toeic",
                  icon: Assets.icons.ielts_toeic
                      .image(width: sizeIcon, height: sizeIcon),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const TopicVocab(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

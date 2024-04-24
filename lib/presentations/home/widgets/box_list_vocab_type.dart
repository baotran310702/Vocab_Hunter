import 'package:english_learner/presentations/home/views/topic_vocabs_page.dart';
import 'package:english_learner/presentations/home/widgets/divider.dart';
import 'package:english_learner/presentations/home/widgets/item_type_vocab.dart';
import 'package:english_learner/presentations/practise_vocab/practise_vocab.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

import '../views/flash_card_page.dart';

class ListVocabType extends StatelessWidget {
  const ListVocabType({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeIcon = 36;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
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
                fontSize: 22,
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
                  icon: Image.asset(
                    AppIcons.flashCard,
                    width: sizeIcon,
                    height: sizeIcon,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const FlashCardPage(),
                      ),
                    );
                  },
                ),
                const DeviderVerticle(),
                ItemTypeVocab(
                  text: "Topics",
                  icon: Image.asset(
                    AppIcons.topic,
                    width: sizeIcon,
                    height: sizeIcon,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const TopicVocab(),
                      ),
                    );
                  },
                ),
                const DeviderVerticle(),
                ItemTypeVocab(
                  text: "Practise",
                  icon: Image.asset(
                    AppIcons.train,
                    width: sizeIcon,
                    height: sizeIcon,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const PractiseVocab(),
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

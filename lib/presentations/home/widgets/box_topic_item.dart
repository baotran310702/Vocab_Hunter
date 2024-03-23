import 'package:english_learner/gen/assets.gen.dart';
import 'package:english_learner/presentations/home/views/list_topic_vocab_page.dart';
import 'package:flutter/material.dart';

import 'list_topics_vocab.dart';

class BoxTopicItem extends StatefulWidget {
  const BoxTopicItem({super.key});

  @override
  State<BoxTopicItem> createState() => _BoxTopicItemState();
}

class _BoxTopicItemState extends State<BoxTopicItem> {
  double scale = 0.6;

  void handleScale() async {
    setState(() {
      scale = 0.8;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      scale = 0.6;
    });
  }

  @override
  Widget build(BuildContext context) {
    double defaultHeight = 160;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const ListDetailTopicVocab();
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: defaultHeight,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Stack(
            children: [
              Container(
                height: defaultHeight,
                width: 160,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 194, 128, 128),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xfff0f0f0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        handleScale();
                      },
                      child: AnimatedScale(
                        scale: scale,
                        duration: const Duration(milliseconds: 200),
                        child: Assets.icons.heart.image(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Topic Name",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Detail topic description here",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xffe0e0e0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "160 words",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xffe0e0e0),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                        ),
                        child: Assets.icons.start.image(
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

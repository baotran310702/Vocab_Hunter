import 'package:english_learner/models/sub_topic.dart';
import 'package:english_learner/utils/extension.dart';
import 'package:english_learner/utils/icons.dart';
//import file extension.dart

import 'package:flutter/material.dart';

class BoxTopicItem extends StatefulWidget {
  final SubTopic subTopic;
  const BoxTopicItem({super.key, required this.subTopic});

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
        /// Handle navigate to detail topic here
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
                        child: Image.asset(AppIcons.heartUnselected),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.subTopic.name.trim().capitalize(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.subTopic.description.capitalize(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
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
                        child: Center(
                          child: Text(
                            "${widget.subTopic.amountVocab.toString()} words",
                            style: const TextStyle(
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
                        child: Image.asset(
                          AppIcons.start,
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

import 'dart:async';

import 'package:english_learner/models/sub_topic.dart';
import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/presentations/home/views/flash_card_page.dart';
import 'package:english_learner/presentations/home/views/list_vocabulary_page.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/enum.dart';
import '../../../utils/icons.dart';

class BoxTopicDetail extends StatefulWidget {
  final double boxHeight;
  final double radius;
  final SubTopic subTopic;
  final Function(String) handleLoadTopic;
  final DownloadStatus downLoadStatus;

  const BoxTopicDetail({
    super.key,
    required this.boxHeight,
    required this.radius,
    required this.subTopic,
    required this.handleLoadTopic,
    required this.downLoadStatus,
  });

  @override
  State<BoxTopicDetail> createState() => _BoxTopicDetailState();
}

class _BoxTopicDetailState extends State<BoxTopicDetail> {
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
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: widget.boxHeight,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: widget.boxHeight / 2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(widget.radius),
                        topRight: Radius.circular(widget.radius),
                      ),
                    ),
                  ),
                  Container(
                    height: widget.boxHeight / 2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color(0xfff0f0f0),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(widget.radius),
                        bottomRight: Radius.circular(widget.radius),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.subTopic.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        Text(
                          widget.subTopic.description,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        CustomButtonTopic(
                          amountWord: widget.subTopic.amountVocab,
                          topicId: widget.subTopic.subTopicId,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  AppColors.secondaryBackgroundButton,
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                  const Size(120, 40),
                                ),
                                side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(
                                    color: AppColors.primaryBackgroundButton,
                                    width: 1,
                                  ), // Adjust color and width as needed
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const FlashCardPage();
                                }));
                              },
                              child: Text(
                                "Flash Card",
                                style: TextStyle(
                                    color: AppColors.secondaryTextButton),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  AppColors.primaryBackgroundButton,
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                  const Size(120, 40),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ListVocabularyItem(
                                        currentVocabList: UserVocab.empty(),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "All Words",
                                style: TextStyle(
                                  color: AppColors.primaryTextButton,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: widget.boxHeight / 2 - (52 / 2),
                right: 10,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        handleScale();
                      },
                      child: AnimatedScale(
                        scale: scale,
                        duration: const Duration(milliseconds: 200),
                        child: Image.asset(
                          AppIcons.heartUnselected,
                          width: 48,
                          height: 48,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        widget.downLoadStatus == DownloadStatus.notDownloaded
            ? InkWell(
                onTap: () {
                  widget.handleLoadTopic(widget.subTopic.name);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  height: widget.boxHeight,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.65),
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.radius),
                    ),
                  ),
                ),
              )
            : widget.downLoadStatus == DownloadStatus.dowloading
                ? Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    height: widget.boxHeight,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.65),
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.radius),
                      ),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Downloading....",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
      ],
    );
  }
}

class CustomButtonTopic extends StatefulWidget {
  final int amountWord;
  final String topicId;
  const CustomButtonTopic({
    super.key,
    required this.amountWord,
    required this.topicId,
  });

  @override
  State<CustomButtonTopic> createState() => _CustomButtonTopicState();
}

class _CustomButtonTopicState extends State<CustomButtonTopic> {
  bool isFront = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        isFront = !isFront;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          height: 40,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: isFront
                ? const Color(0xffe0e0e0)
                : AppColors.backgroundEditButton,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: isFront
                  ? Text(
                      "${widget.amountWord} words",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : const Text(
                      "Train now!",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          height: 40,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: isFront
                ? const Color(0xffe0e0e0)
                : AppColors.backgroundEditButton,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12)),
          ),
          child: Image.asset(
            AppIcons.start,
            width: 24,
            height: 24,
          ),
        ),
      ],
    );
  }
}

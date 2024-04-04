import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/extension.dart';
import 'package:flutter/material.dart';

import '../../dictionary_page/widgets/pronounce_word.dart';

class FlashCard extends StatefulWidget {
  final (VocabularyRemote, VocabularyRemote) vocabularyRemote;

  final Function() voidCallback;
  final Function onSave;

  const FlashCard({
    super.key,
    required this.vocabularyRemote,
    required this.voidCallback,
    required this.onSave,
  });

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  bool isFront = true;

  @override
  void dispose() {
    setState(() {
      isFront = true;
    });
    super.dispose();
  }

  @override
  void initState() {
    isFront = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isFront = !isFront;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: AppColors.backgroundHeader,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: isFront
            ? FrontWidget(
                vocabularyRemote: widget.vocabularyRemote.$1,
                onSave: widget.onSave,
              )
            : BackWidget(
                vocabularyRemote: widget.vocabularyRemote.$2,
                onSave: widget.onSave,
              ),
      ),
    );
  }
}

class FrontWidget extends StatefulWidget {
  final VocabularyRemote vocabularyRemote;
  final Function onSave;

  const FrontWidget({
    super.key,
    required this.vocabularyRemote,
    required this.onSave,
  });

  @override
  State<FrontWidget> createState() => _FrontWidgetState();
}

class _FrontWidgetState extends State<FrontWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundAppbar,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.vocabularyRemote.word != null
              ? Text(
                  widget.vocabularyRemote.word!.capitalize(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 4),
          widget.vocabularyRemote.phonetic != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.vocabularyRemote.phonetic!.capitalize(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    PronounceWord(
                      word: widget.vocabularyRemote.word!,
                      size: 28,
                      color: Colors.black,
                    ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 4),
          Column(
            children: [
              widget.vocabularyRemote.meanings != null &&
                      widget.vocabularyRemote.meanings!.isNotEmpty
                  ? widget.vocabularyRemote.meanings![0].partOfSpeech != null
                      ? Text(
                          widget.vocabularyRemote.meanings![0].partOfSpeech!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox()
                  : const SizedBox(),
              widget.vocabularyRemote.meanings![0].definitions != null &&
                      widget
                          .vocabularyRemote.meanings![0].definitions!.isNotEmpty
                  ? Column(
                      children: [
                        const Text(
                          "Meanings",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.vocabularyRemote.meanings![0]
                                      .definitions!.length >
                                  3
                              ? 3
                              : widget.vocabularyRemote.meanings![0]
                                  .definitions!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.vocabularyRemote.meanings![0]
                                        .definitions![index].definition!
                                        .startWithDot(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    maxLines: 4,
                                  ),
                                  widget.vocabularyRemote.meanings![0]
                                              .definitions![index].example !=
                                          null
                                      ? Text(
                                          widget.vocabularyRemote.meanings![0]
                                              .definitions![index].example!
                                              .startWithExample(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.italic,
                                          ),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 5,
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}

class BackWidget extends StatefulWidget {
  final VocabularyRemote vocabularyRemote;
  final Function onSave;

  const BackWidget({
    super.key,
    required this.vocabularyRemote,
    required this.onSave,
  });

  @override
  State<BackWidget> createState() => _BackWidgetState();
}

class _BackWidgetState extends State<BackWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundAppbar,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.vocabularyRemote.word != null
              ? Text(
                  widget.vocabularyRemote.word!.capitalize(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 4),
          widget.vocabularyRemote.phonetic != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.vocabularyRemote.phonetic!.capitalize(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    PronounceWord(
                      word: widget.vocabularyRemote.word!,
                      size: 28,
                      color: Colors.black,
                    ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 4),
          widget.vocabularyRemote.meanings![0].partOfSpeech != null
              ? Text(
                  widget.vocabularyRemote.meanings![0].partOfSpeech!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                )
              : const SizedBox(),
          widget.vocabularyRemote.meanings![0].definitions != null &&
                  widget.vocabularyRemote.meanings![0].definitions!.isNotEmpty
              ? Column(
                  children: [
                    const Text(
                      "Meanings",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.vocabularyRemote.meanings![0]
                                  .definitions!.length >
                              3
                          ? 3
                          : widget.vocabularyRemote.meanings![0].definitions!
                              .length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.vocabularyRemote.meanings![0]
                                    .definitions![index].definition!
                                    .startWithDot(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              widget.vocabularyRemote.meanings![0]
                                          .definitions![index].example !=
                                      null
                                  ? Text(
                                      widget.vocabularyRemote.meanings![0]
                                          .definitions![index].example!
                                          .startWithExample(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      textAlign: TextAlign.start,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

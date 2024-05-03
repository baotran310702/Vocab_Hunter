import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/extension.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

class BoxVocab extends StatefulWidget {
  final VocabularyRemote englishVocabulary;

  final VocabularyRemote vietnameseVocabulary;

  const BoxVocab({
    super.key,
    required this.englishVocabulary,
    required this.vietnameseVocabulary,
  });

  @override
  State<BoxVocab> createState() => _BoxVocabState();
}

class _BoxVocabState extends State<BoxVocab> {
  double scale = 1;
  void handleScale() async {
    setState(() {
      scale = 0.9;
    });
    await Future.delayed(const Duration(milliseconds: 160));
    setState(() {
      scale = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handleScale();
      },
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 280),
        child: Container(
          padding: const EdgeInsets.all(6.0),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 185,
          height: 185,
          decoration: BoxDecoration(
            color: AppColors.boxVocabColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    AppIcons.tagSave,
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
              Text(
                widget.englishVocabulary.word?.capitalize() ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.englishVocabulary.phonetic ?? "",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                widget.englishVocabulary.meanings?[0].partOfSpeech ?? "",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.vietnameseVocabulary.word ?? "",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

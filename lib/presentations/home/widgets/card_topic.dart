import 'package:english_learner/models/vocabulary/vocab_topic.dart';
import 'package:english_learner/presentations/dictionary_page/widgets/pronounce_word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global_instance/bloc/global_bloc.dart';

class CardTopic extends StatefulWidget {
  final VocabTopic vocabulary;
  const CardTopic({super.key, required this.vocabulary});

  @override
  State<CardTopic> createState() => _CardTopicState();
}

class _CardTopicState extends State<CardTopic> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<GlobalBloc>().add(ChangeFlashCardSide());
          },
          child: state.isFront ? frontSide(context) : backSide(context),
        );
      },
    );
  }

  Container frontSide(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.vocabulary.word,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.vocabulary.type.contains("(")
                ? widget.vocabulary.type
                : "(${widget.vocabulary.type})",
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              PronounceWord(word: widget.vocabulary.word),
              const SizedBox(width: 14),
              Text(
                widget.vocabulary.pronounce.contains("/")
                    ? widget.vocabulary.pronounce
                    : "/${widget.vocabulary.pronounce}/",
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.vocabulary.exampleEnglish,
            style: const TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            widget.vocabulary.exampleVietnamese,
            style: const TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Container backSide(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.vocabulary.word,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.vocabulary.type.contains("(")
                ? widget.vocabulary.type
                : "(${widget.vocabulary.type})",
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              PronounceWord(word: widget.vocabulary.word),
              const SizedBox(width: 14),
              Text(
                "/${widget.vocabulary.pronounce}/",
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.vocabulary.meaning,
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

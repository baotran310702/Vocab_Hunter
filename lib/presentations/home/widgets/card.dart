import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/extension.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dictionary_page/widgets/pronounce_word.dart';
import '../../global_instance/bloc/global_bloc.dart';

class FlashCard extends StatefulWidget {
  final (VocabularyRemote, VocabularyRemote)? vocabularyRemote;

  final Function onSave;
  final bool isSaved;

  const FlashCard({
    super.key,
    this.vocabularyRemote,
    required this.onSave,
    required this.isSaved,
  });

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<GlobalBloc>().add(ChangeFlashCardSide());
          },
          child: frontSide(context, state),
        );
      },
    );
  }

  Container frontSide(BuildContext context, GlobalState state) {
    return Container(
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
      child: FrontWidget(
        vocabularyRemote: widget.vocabularyRemote != null
            ? state.isFront
                ? widget.vocabularyRemote!.$1
                : widget.vocabularyRemote!.$2
            : VocabularyRemote.empty(),
        onSave: widget.onSave,
        isSaved: widget.isSaved,
      ),
    );
  }
}

class FrontWidget extends StatefulWidget {
  final VocabularyRemote vocabularyRemote;
  final Function onSave;
  final bool isSaved;

  const FrontWidget({
    super.key,
    required this.vocabularyRemote,
    required this.onSave,
    required this.isSaved,
  });

  @override
  State<FrontWidget> createState() => _FrontWidgetState();
}

class _FrontWidgetState extends State<FrontWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
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
                          size: 32,
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
                      ? widget.vocabularyRemote.meanings![0].partOfSpeech !=
                              null
                          ? Text(
                              widget
                                  .vocabularyRemote.meanings![0].partOfSpeech!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            )
                          : const SizedBox()
                      : const SizedBox(),
                  widget.vocabularyRemote.meanings![0].definitions != null &&
                          widget.vocabularyRemote.meanings![0].definitions!
                              .isNotEmpty
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        maxLines: 3,
                                      ),
                                      widget
                                                  .vocabularyRemote
                                                  .meanings![0]
                                                  .definitions![index]
                                                  .example !=
                                              null
                                          ? Text(
                                              widget
                                                  .vocabularyRemote
                                                  .meanings![0]
                                                  .definitions![index]
                                                  .example!
                                                  .startWithExample(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
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
        ),
        Positioned(
          top: 20,
          right: 20,
          child: InkWell(
            onTap: () {
              widget.onSave();
            },
            child: Image.asset(
              widget.isSaved ? AppIcons.tagSaved : AppIcons.tagSave,
              width: 48,
              height: 48,
            ),
          ),
        ),
      ],
    );
  }
}

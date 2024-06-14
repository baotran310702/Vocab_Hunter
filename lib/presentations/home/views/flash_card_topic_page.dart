import 'dart:math';

import 'package:english_learner/models/sub_topic.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/global_instance/bloc/global_bloc.dart';
import 'package:english_learner/presentations/global_instance/loading.dart';
import 'package:english_learner/presentations/home/bloc/topic_vocab_bloc.dart';
import 'package:english_learner/presentations/home/widgets/card_topic.dart';
import 'package:english_learner/presentations/user_vocabulary/bloc/manage_vocab_bloc.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/toasty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../../models/user_vocab.dart';

class FlashCardTopicPage extends StatefulWidget {
  final SubTopic subTopic;
  const FlashCardTopicPage({
    super.key,
    required this.subTopic,
  });

  @override
  State<FlashCardTopicPage> createState() => _FlashCardTopicPageState();
}

class _FlashCardTopicPageState extends State<FlashCardTopicPage> {
  final TextEditingController vocabController = TextEditingController();
  List<int> indexFront = [];

  @override
  void dispose() {
    vocabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CardSwiperController cardControllers = CardSwiperController();
    return BlocProvider(
      create: (context) => TopicVocabularyBloc()
        ..add(
          GetVocabTopicEvent(
            subTopic: widget.subTopic,
          ),
        ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyAppbar(
          text: widget.subTopic.name.trim().toUpperCase(),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }

            Navigator.pop(context);
          },
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<TopicVocabularyBloc, TopicVocabularyState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Flexible(
                            child: LoadingPage(
                          message: "Recommending, please wait...",
                        ));
                      } else {
                        List<Widget> cards = state.listVocabulary
                            .map(
                              (e) => CardTopic(
                                vocabulary: e,
                              ),
                            )
                            .toList();

                        if (cards.isEmpty) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: const Text("No data"),
                          );
                        }

                        return Flexible(
                          child: Column(
                            children: [
                              Flexible(
                                child: CardSwiper(
                                  controller: cardControllers,
                                  isDisabled: true,
                                  cardsCount: cards.length,
                                  numberOfCardsDisplayed: 3,
                                  backCardOffset: const Offset(0, 40),
                                  padding: const EdgeInsets.all(12.0),
                                  cardBuilder: (
                                    context,
                                    index,
                                    horizontalThresholdPercentage,
                                    verticalThresholdPercentage,
                                  ) {
                                    return cards[index];
                                  },
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          AppColors.backgroundEditButton,
                                        ),
                                        fixedSize:
                                            MaterialStateProperty.all<Size>(
                                          Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2,
                                              52),
                                        ),
                                        side: MaterialStateProperty.all<
                                            BorderSide>(
                                          BorderSide(
                                            color:
                                                AppColors.backgroundEditButton,
                                            width: 1,
                                          ), // Adjust color and width as needed
                                        ),
                                      ),
                                      onPressed: () {
                                        int index = Random().nextInt(10);

                                        context
                                            .read<GlobalBloc>()
                                            .add(ResetFlashCardSide());

                                        if (index % 2 == 0) {
                                          cardControllers
                                              .swipe(CardSwiperDirection.left);
                                        } else {
                                          cardControllers
                                              .swipe(CardSwiperDirection.right);
                                        }
                                      },
                                      child: const Text(
                                        "Next",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSave((VocabularyRemote, VocabularyRemote) word,
      List<UserVocab> listLearningWords, String listId) {
    bool isSaved = listLearningWords.indexWhere((element) =>
            element.listId == listId &&
            element.listVocabulary.entries.first.value.contains(word.$1)) !=
        -1;
    if (isSaved) {
      context.read<ManageVocabBloc>().add(RemoveFromListLearning(
            vocab: word.$1,
          ));

      Toasty.showToast(
        msg: "Removed from list!",
        context: context,
      );
    } else {
      context
          .read<ManageVocabBloc>()
          .add(AddVocabToListLearning(vocabEng: word.$1, vocabViet: word.$2));
      Toasty.showToast(
        msg: "Added to list!",
        context: context,
      );
    }
  }
}

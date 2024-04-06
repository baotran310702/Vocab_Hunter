import 'dart:math';

import 'package:english_learner/presentations/global_widgets/appbar.dart';
import 'package:english_learner/presentations/global_widgets/bloc/global_bloc.dart';
import 'package:english_learner/presentations/home/widgets/card.dart';
import 'package:english_learner/presentations/user_vocabulary/bloc/manage_vocab_bloc.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class FlashCardPage extends StatefulWidget {
  const FlashCardPage({super.key});

  @override
  State<FlashCardPage> createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  final TextEditingController vocabController = TextEditingController();
  List<Widget> cards = [];
  List<int> indexFront = [];

  bool isDispose = false;

  @override
  void dispose() {
    vocabController.dispose();
    super.dispose();
    isDispose = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppbar(text: "Flash Card"),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 52,
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: TextFormField(
                      controller: vocabController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Write your vocabulary here',
                        //border radius
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryBackgroundButton,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                      onTapOutside: (_) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        AppColors.backgroundEditButton,
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width / 3.8, 52),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                          color: AppColors.backgroundEditButton,
                          width: 1,
                        ), // Adjust color and width as needed
                      ),
                    ),
                    onPressed: () {
                      context.read<ManageVocabBloc>().add(
                            GetSimilarityVocabLocalEvent(
                                inputVocab: vocabController.text.isEmpty
                                    ? "hello"
                                    : vocabController.text),
                          );
                    },
                    child: const Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<ManageVocabBloc, ManageVocabState>(
                buildWhen: (previous, current) {
                  return previous.vocabRemoteList != current.vocabRemoteList ||
                      previous.isLoading != current.isLoading;
                },
                builder: (context, state) {
                  int index = -1;
                  cards = state.vocabRemoteList.map((e) {
                    index = index + 1;
                    return FlashCard(
                        vocabularyRemote: e,
                        voidCallback: () {
                          _onFlip(index);
                        },
                        onSave: () {
                          _onSave(index);
                        });
                  }).toList();
                  if (state.isLoading) {
                    return const Flexible(child: CircularProgressIndicator());
                  }
                  if (state.similarVocabs.isEmpty) {
                    return Flexible(
                      child: Center(
                        child: Text(
                          "The is no card recommended, please search!",
                          style: TextStyle(
                            color: AppColors.textColors,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    final CardSwiperController controller =
                        CardSwiperController();

                    return Flexible(
                      child: Column(
                        children: [
                          Flexible(
                            child: CardSwiper(
                              controller: controller,
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
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      AppColors.backgroundEditButton,
                                    ),
                                    fixedSize: MaterialStateProperty.all<Size>(
                                      Size(
                                          MediaQuery.of(context).size.width /
                                              1.2,
                                          52),
                                    ),
                                    side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(
                                        color: AppColors.backgroundEditButton,
                                        width: 1,
                                      ), // Adjust color and width as needed
                                    ),
                                  ),
                                  onPressed: () {
                                    _changeNext(controller);
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
    );
  }

  void _onFlip(int index) {
    if (indexFront.contains(index)) {
      setState(() {
        indexFront.clear();
      });
    } else {
      setState(() {
        indexFront.clear();
        indexFront.add(index);
      });
    }
  }

  void _onSave(int index) {}

  void _changeNext(CardSwiperController controller) {
    //random index value

    int index = Random().nextInt(10);
    context.read<GlobalBloc>().add(ResetFlashCardSide());

    if (index % 2 == 0) {
      controller.swipe(CardSwiperDirection.left);
    } else {
      controller.swipe(CardSwiperDirection.right);
    }
  }
}

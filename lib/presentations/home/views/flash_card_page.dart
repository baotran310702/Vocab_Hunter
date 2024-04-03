import 'package:english_learner/presentations/global_widgets/appbar.dart';
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
  final CardSwiperController controller = CardSwiperController();
  final TextEditingController vocabController = TextEditingController();
  List<FlashCard> cards = [];

  @override
  void dispose() {
    controller.dispose();
    vocabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageVocabBloc, ManageVocabState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const MyAppbar(text: "Flash Card"),
          body: Container(
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
                      onPressed: () async {
                        context.read<ManageVocabBloc>().add(
                              GetSimilarityVocabEvent(
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
                state.isLoading
                    ? const Flexible(child: CircularProgressIndicator())
                    : Flexible(
                        child: CardSwiper(
                          controller: controller,
                          cardsCount: cards.length,
                          numberOfCardsDisplayed: 3,
                          backCardOffset: const Offset(0, 60),
                          padding: const EdgeInsets.all(12.0),
                          onSwipe: _onSwipe,
                          onUndo: _onUndo,
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
              ],
            ),
          ),
        );
      },
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    controller.swipe(CardSwiperDirection.left);
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    controller.swipe(CardSwiperDirection.right);

    return true;
  }
}

import 'package:english_learner/presentations/global_widgets/appbar.dart';
import 'package:english_learner/presentations/home/widgets/card.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class FlashCardPage extends StatefulWidget {
  const FlashCardPage({super.key});

  @override
  State<FlashCardPage> createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  final CardSwiperController controller = CardSwiperController();
  List<Widget> cards = const [
    FlashCard(),
    FlashCard(),
    FlashCard(),
    FlashCard(),
    FlashCard(),
    FlashCard(),
    FlashCard(),
    FlashCard(),
    FlashCard(),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(text: "Flash Card"),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Flexible(
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
                }),
          ),
          const SizedBox(
            height: 20,
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
                    Size(MediaQuery.of(context).size.width / 2.5, 52),
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(
                      color: AppColors.primaryBackgroundButton,
                      width: 1,
                    ), // Adjust color and width as needed
                  ),
                ),
                onPressed: () {},
                child: const Text("Flip"),
              ),
              const SizedBox(
                width: 40,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.primaryBackgroundButton,
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                    Size(MediaQuery.of(context).size.width / 2.5, 52),
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(
                      color: AppColors.primaryBackgroundButton,
                      width: 1,
                    ), // Adjust color and width as needed
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Remembered",
                  style: TextStyle(
                    color: AppColors.primaryTextButton,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          )
        ]),
      ),
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

import 'package:english_learner/presentations/global_widgets/appbar.dart';
import 'package:english_learner/presentations/home/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class FlashCardPage extends StatefulWidget {
  const FlashCardPage({super.key});

  @override
  State<FlashCardPage> createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  final CardSwiperController controller = CardSwiperController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                numberOfCardsDisplayed: 6,
                backCardOffset: const Offset(12, 12),
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
        ]),
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    print("current index: $currentIndex");
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

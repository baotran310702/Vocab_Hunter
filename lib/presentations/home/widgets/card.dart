import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlashCard extends StatefulWidget {
  const FlashCard({super.key});

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  bool isFront = true;
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
        height: 600,
        decoration: BoxDecoration(
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: isFront ? const FrontWidget() : const BackWidget(),
      ),
    );
  }
}

class FrontWidget extends StatelessWidget {
  const FrontWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Front Card'));
  }
}

class BackWidget extends StatelessWidget {
  const BackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Back Card'));
  }
}

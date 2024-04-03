import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class FlashCard extends StatefulWidget {
  final String title;
  const FlashCard({super.key, required this.title});

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
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: AppColors.backgroundHeader,
          borderRadius: BorderRadius.circular(20),
        ),
        child: isFront
            ? FrontWidget(
                title: widget.title,
              )
            : BackWidget(
                title: widget.title,
              ),
      ),
    );
  }
}

class FrontWidget extends StatelessWidget {
  final String title;
  const FrontWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title));
  }
}

class BackWidget extends StatelessWidget {
  final String title;

  const BackWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title));
  }
}

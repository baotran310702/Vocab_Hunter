import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class ItemTypeVocab extends StatefulWidget {
  final String text;
  final Widget icon;
  const ItemTypeVocab({super.key, required this.text, required this.icon});

  @override
  State<ItemTypeVocab> createState() => _ItemTypeVocabState();
}

class _ItemTypeVocabState extends State<ItemTypeVocab> {
  double scale = 1;

  void handleScale() async {
    setState(() {
      scale = 1.4;
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
        duration: const Duration(milliseconds: 300),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          width: 95,
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.icon,
              const SizedBox(height: 10),
              Text(
                widget.text,
                style: TextStyle(
                  color: AppColors.mainTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

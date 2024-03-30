import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Transform.scale(
        scale: 0.4,
        child: Image.asset(
          AppIcons.backBtn,
          width: 12,
          height: 12,
        ),
      ),
    );
  }
}

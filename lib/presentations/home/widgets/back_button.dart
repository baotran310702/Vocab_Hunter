import 'package:english_learner/gen/assets.gen.dart';
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
        child: Assets.icons.back_btn.image(
          width: 12,
          height: 12,
        ),
      ),
    );
  }
}

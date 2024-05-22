import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget {
  final Function()? onPress;
  const ButtonBack({super.key, this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress ??
          () {
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

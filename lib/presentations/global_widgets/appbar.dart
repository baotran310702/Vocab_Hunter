import 'package:english_learner/presentations/home/widgets/back_button.dart';
import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  const MyAppbar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
      leading: const ButtonBack(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
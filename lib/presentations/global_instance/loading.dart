import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final String message;
  const LoadingPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppIcons.logoText, width: 300, height: 120),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          Image.asset(AppIcons.loading, width: 150, height: 150),
          Stack(children: [
            Image.asset(AppIcons.bathingBoi, width: 280, height: 280),
            Image.asset(AppIcons.bubble, width: 280, height: 280),
          ]),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}

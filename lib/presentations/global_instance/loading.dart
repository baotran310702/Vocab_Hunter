import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final String message;
  final double? customHeight;
  const LoadingPage({super.key, required this.message, this.customHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: customHeight ?? MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppIcons.logo, width: 300, height: 240),
          const SizedBox(
            height: 30,
          ),
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
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

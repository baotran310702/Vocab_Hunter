import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double leftPercent = 0.1;

  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      height: 80,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          const Text(
            "Progress: 1/10",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            height: 12,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: AppColors.backgroundAppbar,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.borderInput,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 18,
                      width:
                          MediaQuery.of(context).size.width * 0.5 * leftPercent,
                    ),
                    Container(
                      height: 18,
                      width: MediaQuery.of(context).size.width *
                          0.5 *
                          (1 - leftPercent),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

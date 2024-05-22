import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final int amount;
  final int total;
  const CustomSlider({
    super.key,
    required this.amount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    double leftPercent = (amount / total).toDouble();
    return Container(
      height: 18,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        color: AppColors.achievedLeft,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.achievedSlider,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 18,
                width: MediaQuery.of(context).size.width * 0.5 * leftPercent,
              ),
              Container(
                height: 18,
              width:
                    MediaQuery.of(context).size.width * 0.5 * (1 - leftPercent),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:english_learner/presentations/user_profile/widgets/custom_slider.dart';
import 'package:english_learner/utils/colors.dart';

import 'package:flutter/material.dart';

import '../../../models/achievement.dart';
import '../../../utils/converter.dart';

class ItemAchievement extends StatelessWidget {
  final Achievement achievement;
  const ItemAchievement({
    super.key,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      height: 120,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 6,
          ),
          Container(
            width: 110,
            height: 110,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.backgroundItemAchiement,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Image.asset(
              CustomConverter.convertAchievement(achievement.type),
              width: 60,
              height: 60,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(
                  achievement.title,
                  style: TextStyle(
                    color: AppColors.mainTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  achievement.description,
                  style: TextStyle(
                    color: AppColors.mainTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    CustomSlider(
                      amount: achievement.amount,
                      total: achievement.total,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${achievement.amount}/${achievement.total}",
                      style: TextStyle(
                        color: AppColors.textColors,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

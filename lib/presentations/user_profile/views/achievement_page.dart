import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/converter.dart';
import 'package:flutter/material.dart';

import '../../../models/achievement.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> initdefault = List.generate(7, (value) => 0);
    return Scaffold(
      backgroundColor: AppColors.backgroundAppbar,
      extendBodyBehindAppBar: true,
      appBar: const MyAppbar(text: "Achievements"),
      body: SafeArea(
        child: Container(
          color: AppColors.backgroundPageAchievement,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: initdefault.length,
                  itemBuilder: (context, index) => ItemAchievement(
                    achievement: Achievement.defaultInit(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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

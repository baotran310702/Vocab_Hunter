import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/user_profile/widgets/item_achievement.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../../models/achievement.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Achievement> initdefault = Achievement.defaultListAchievement;
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
                    achievement: initdefault[index],
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

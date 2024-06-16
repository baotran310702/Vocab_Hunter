import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/user_profile/bloc/manage_user_bloc.dart';
import 'package:english_learner/presentations/user_profile/widgets/item_achievement.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/achievement.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAppbar,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: const MyAppbar(text: "Achievements"),
      body: BlocBuilder<ManageUserProfileBloc, ManageUserState>(
        builder: (context, state) {
          List<Achievement> userAchievement = state.userModel.achievements;

          return SafeArea(
            child: Container(
              color: AppColors.backgroundPageAchievement,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: userAchievement.length,
                      itemBuilder: (context, index) => ItemAchievement(
                        achievement: userAchievement[index],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

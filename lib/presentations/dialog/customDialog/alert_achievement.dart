import 'package:english_learner/models/achievement.dart';
import 'package:english_learner/presentations/user_profile/views/achievement_page.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/converter.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

class AlertAchievement extends StatefulWidget {
  final Achievement achievement;
  const AlertAchievement({super.key, required this.achievement});

  @override
  State<AlertAchievement> createState() => _AlertAchievementState();
}

class _AlertAchievementState extends State<AlertAchievement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 4,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Congratulations!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Stack(children: [
                Positioned(
                  child: Transform.scale(
                      scale: 3,
                      child: Image.asset(AppIcons.backgroundAnimation)),
                ),
                Image.asset(
                  CustomConverter.convertAchievementType(
                      widget.achievement.type),
                ),
                Image.asset(
                  AppIcons.congrasAnimation,
                ),
                Positioned(
                  right: -50,
                  child: Image.asset(
                    AppIcons.congrasAnimation,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: -50,
                  child: Image.asset(
                    AppIcons.congrasAnimation,
                  ),
                ),
                Positioned(
                  bottom: -30,
                  right: -60,
                  child: Transform.scale(
                      scale: 0.3, child: Image.asset(AppIcons.trophyAnimation)),
                ),
                Positioned(
                  bottom: -40,
                  left: -20,
                  child: Transform.scale(
                      scale: 1.3, child: Image.asset(AppIcons.fireAnimation)),
                )
              ]),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "You've got a new achievement ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                widget.achievement.title,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.clip,
                maxLines: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Thanks for your keeping up! ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AchievementPage();
                      }));
                    },
                    child: Text(
                      "See all here!",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red[800],
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.3,
                    52,
                  ),
                  backgroundColor: AppColors.titleHeaderColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

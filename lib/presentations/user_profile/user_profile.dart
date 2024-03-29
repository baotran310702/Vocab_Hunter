import 'package:english_learner/presentations/user_profile/views/achievements.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

import '../home/widgets/header_informations.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.backgroundAppbar,
      body: SafeArea(
        child: Container(
          color: AppColors.backgroundHeader,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const HeaderInformations(
                  title: "",
                  description: "",
                  isUserProifile: true,
                ),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColorAchievement,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Your Achievement",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const AchievementPage();
                                }));
                              },
                              child: const Text(
                                "See more...",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            BoxAchievement(
                              icon: Image.asset(
                                AppIcons.sleepyBoi,
                                width: 80,
                                height: 80,
                              ),
                              title: "Patient",
                            ),
                            BoxAchievement(
                              icon: Image.asset(
                                AppIcons.writingBoi,
                                width: 80,
                                height: 80,
                              ),
                              title: "Hardworking",
                            ),
                            BoxAchievement(
                              icon: Image.asset(
                                AppIcons.eatingBoi,
                                width: 80,
                                height: 80,
                              ),
                              title: "Toeic Achiev",
                            ),
                            BoxAchievement(
                              icon: Image.asset(
                                AppIcons.sleepyBoi,
                                width: 80,
                                height: 80,
                              ),
                              title: "IELTS Achiev",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Setting",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Items(
                      text: "User Informations",
                      icon: AppIcons.userProfile,
                    ),
                    Items(
                      text: "Security",
                      icon: AppIcons.security,
                    ),
                    Items(
                      text: "Targets",
                      icon: AppIcons.cup,
                    ),
                    Items(
                      text: "Your Favourite",
                      icon: AppIcons.heartUnselected,
                    ),
                    Items(
                      text: "In Progressing",
                      icon: AppIcons.following,
                    ),
                    Items(
                      text: "Notifications",
                      icon: AppIcons.alert,
                    ),
                    Items(
                      text: "Language",
                      icon: AppIcons.language,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),

                //buttom log out
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.9,
                      52,
                    ),
                    backgroundColor: AppColors.colorExitButton,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/", (route) => false);
                  },
                  child: const Text("Log Out"),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Items extends StatelessWidget {
  final String icon;
  final String text;
  const Items({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      width: MediaQuery.of(context).size.width,
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(
                icon,
                width: 22,
                height: 22,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                text,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Transform.rotate(
            angle: 3.14,
            child: Image.asset(
              AppIcons.arrow,
              width: 22,
              height: 22,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

class BoxAchievement extends StatelessWidget {
  final Widget icon;
  final String title;
  const BoxAchievement({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.titleHeaderColor,
              borderRadius: BorderRadius.circular(20),
            ),
            width: 100,
            height: 100,
            child: Center(
              child: icon,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

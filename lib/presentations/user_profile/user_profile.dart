import 'package:english_learner/presentations/user_profile/bloc/manage_user_bloc.dart';
import 'package:english_learner/presentations/user_profile/views/achievement_page.dart';
import 'package:english_learner/presentations/user_profile/views/change_password_page.dart';
import 'package:english_learner/presentations/user_profile/views/user_informations.dart';
import 'package:english_learner/presentations/user_profile/views/your_favourite_page.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/converter.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/bloc/authentication_bloc.dart';
import '../home/widgets/header_informations.dart';
import 'views/setting_nofitications.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.backgroundHeader,
      body: BlocBuilder<ManageUserProfileBloc, ManageUserState>(
        builder: (context, state) {
          bool isHaveAchievement = false;
          if (state.userModel.achievements.isNotEmpty) {
            for (int i = 0; i < state.userModel.achievements.length; i++) {
              if (state.userModel.achievements[i].total ==
                  state.userModel.achievements[i].amount) {
                isHaveAchievement = true;
                break;
              }
            }
          }
          return SafeArea(
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
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const AchievementPage();
                                      }));
                                    },
                                    child: const Text(
                                      "Explore More...",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isHaveAchievement
                              ? Center(
                                  child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 60),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
                                            "Receive achievemement by completed it!, ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.clip,
                                            maxLines: 2,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return const AchievementPage();
                                              }));
                                            },
                                            child: Text(
                                              "Explore now?",
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
                                    ],
                                  ),
                                ))
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (int i = 0;
                                          i <
                                              state.userModel.achievements
                                                  .length;
                                          i++)
                                        if (state.userModel.achievements[i]
                                                .total ==
                                            state.userModel.achievements[i]
                                                .amount)
                                          BoxAchievement(
                                            icon: Image.asset(
                                              CustomConverter
                                                  .convertAchievement(state
                                                      .userModel
                                                      .achievements[i]
                                                      .type),
                                              width: 80,
                                              height: 80,
                                            ),
                                            title: state.userModel
                                                .achievements[i].title,
                                          ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 4),
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
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const UserInformations();
                            }));
                          },
                        ),
                        Items(
                          text: "Change Password",
                          icon: AppIcons.security,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ChangePasswordPage();
                            }));
                          },
                        ),
                        // Items(
                        //   text: "Targets",
                        //   icon: AppIcons.cup,
                        //   onTap: () {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (context) {
                        //       return const UserTest();
                        //     }));
                        //   },
                        // ),
                        Items(
                          text: "Your Favourite",
                          icon: AppIcons.heartUnselected,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const YourFavouritePage();
                            }));
                          },
                        ),
                        Items(
                          text: "In Progressing",
                          icon: AppIcons.following,
                          onTap: () {},
                        ),
                        Items(
                          text: "Notifications",
                          icon: AppIcons.alert,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SettingNotifications();
                                },
                              ),
                            );
                          },
                        ),
                        Items(
                          text: "Language",
                          icon: AppIcons.language,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
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
                        _onLogout();
                        Navigator.pushReplacementNamed(context, '/');
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
          );
        },
      ),
    );
  }

  _onLogout() {
    BlocProvider.value(
      value: AuthenticationBloc()
        ..add(
          Logout(),
        ),
    );
  }
}

class Items extends StatelessWidget {
  final String icon;
  final String text;
  final Function onTap;
  const Items({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
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

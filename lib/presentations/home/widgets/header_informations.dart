import 'package:english_learner/presentations/global_instance/bloc/global_bloc.dart';
import 'package:english_learner/presentations/remote_notification/notification_remote.dart';
import 'package:english_learner/presentations/user_profile/bloc/manage_user_bloc.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderInformations extends StatefulWidget {
  final String description;
  final String title;
  final bool? isUserProifile;
  const HeaderInformations({
    super.key,
    required this.title,
    required this.description,
    this.isUserProifile = false,
  });

  @override
  State<HeaderInformations> createState() => _HeaderInformationsState();
}

class _HeaderInformationsState extends State<HeaderInformations> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
          color: AppColors.backgroundHeader,
          border: Border.all(
            color: AppColors.textInputs,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Stack(children: [
        Row(
          children: [
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    AppIcons.logoText,
                    width: 156,
                    height: 60,
                  ),
                  informationHeader(),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Image.asset(
                AppIcons.animation,
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          right: -10,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationRemote(),
                ),
              );
            },
            child: Stack(
              children: [
                Image.asset(
                  AppIcons.bellAlert,
                  width: 48,
                  height: 48,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: BlocBuilder<GlobalBloc, GlobalState>(
                      builder: (context, state) {
                        return Center(
                          child: Text(
                            state.notificationApps.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  Container informationHeader() {
    return Container(
      child: widget.isUserProifile != null && widget.isUserProifile == false
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: AppColors.titleHeaderColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.description,
                  style: TextStyle(
                    color: AppColors.descriptionHeaderColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
          : BlocBuilder<ManageUserProfileBloc, ManageUserState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Image.asset(
                          AppIcons.user,
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      state.userModel.userName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                );
              },
            ),
    );
  }
}

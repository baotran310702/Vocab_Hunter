import 'package:english_learner/models/time_notification.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/user_profile/bloc/manage_user_bloc.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/extension.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingNotifications extends StatefulWidget {
  const SettingNotifications({super.key});

  @override
  State<SettingNotifications> createState() => _SettingNotificationsState();
}

class _SettingNotificationsState extends State<SettingNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(text: "Notifications"),
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<ManageUserProfileBloc, ManageUserState>(
              builder: (context, state) {
                if (state.listTimeNotification.listTimeNotification.isEmpty) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: AppColors.backgroundHeader,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "there is no notification created yet, please add new one."
                                .capitalize(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ));
                } else {
                  List<TimeNotification> switchValues =
                      state.listTimeNotification.listTimeNotification;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: AppColors.backgroundHeader,
                    child: Column(
                      children: [
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(index.toString()),
                              onDismissed: (direction) {
                                final removedItem = switchValues[index];
                                switchValues.removeAt(index);
                                context.read<ManageUserProfileBloc>().add(
                                      RemoveTimeNotificationEvent(
                                        timeNotification: removedItem,
                                      ),
                                    );
                              },
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Text(switchValues[index]
                                        .time
                                        .toHourMinute()),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (builder) {
                                            return TimePickerDialog(
                                              initialTime: TimeOfDay.now(),
                                            );
                                          },
                                        ).then((value) {
                                          setState(() {
                                            switchValues[index] =
                                                switchValues[index]
                                                    .copyWith(time: value);
                                          });

                                          context
                                              .read<ManageUserProfileBloc>()
                                              .add(
                                                UpdateTimeNotification(
                                                  timeNotification:
                                                      switchValues[index]
                                                          .copyWith(
                                                              time: value),
                                                ),
                                              );
                                        });
                                      },
                                      child: Image.asset(
                                        AppIcons.edit,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Switch(
                                  activeTrackColor: AppColors.titleHeaderColor,
                                  trackOutlineColor: MaterialStateProperty.all(
                                      AppColors.titleHeaderColor),
                                  inactiveThumbColor:
                                      AppColors.titleHeaderColor,
                                  inactiveTrackColor: Colors.white,
                                  value: switchValues[index].isActive,
                                  onChanged: (value) {
                                    setState(() {
                                      switchValues[index] = switchValues[index]
                                          .copyWith(isActive: value);
                                    });

                                    context.read<ManageUserProfileBloc>().add(
                                          UpdateTimeNotification(
                                            timeNotification:
                                                switchValues[index]
                                                    .copyWith(isActive: value),
                                          ),
                                        );
                                  },
                                ),
                              ),
                            );
                          },
                          itemCount: switchValues.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (builder) {
                      return TimePickerDialog(
                        initialTime: TimeOfDay.now(),
                      );
                    },
                  ).then((value) {
                    int id = context
                        .read<ManageUserProfileBloc>()
                        .state
                        .listTimeNotification
                        .listTimeNotification
                        .length;
                    setState(() {
                      context.read<ManageUserProfileBloc>().add(
                            AddTimeNotificationEvent(
                              timeNotification: TimeNotification(
                                id: id,
                                time: value,
                                isActive: true,
                              ),
                            ),
                          );
                    });
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.titleHeaderColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

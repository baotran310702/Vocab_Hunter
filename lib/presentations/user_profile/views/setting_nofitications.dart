import 'package:english_learner/models/time_notification.dart';
import 'package:english_learner/presentations/global_widgets/appbar.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

class SettingNotifications extends StatefulWidget {
  const SettingNotifications({super.key});

  @override
  State<SettingNotifications> createState() => _SettingNotificationsState();
}

class _SettingNotificationsState extends State<SettingNotifications> {
  List<TimeNotification> switchValues = [
    TimeNotification.initial(),
    TimeNotification.initial(),
    TimeNotification.initial(),
    TimeNotification.initial(),
    TimeNotification.initial(),
    TimeNotification.initial(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(text: "Notifications"),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
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

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("$removedItem removed from list"),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Row(
                            children: [
                              Text(switchValues[index].time.toString()),
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
                                      switchValues[index] = switchValues[index]
                                          .copyWith(time: value);
                                    });
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
                            inactiveThumbColor: AppColors.titleHeaderColor,
                            inactiveTrackColor: Colors.white,
                            value: switchValues[index].isActive,
                            onChanged: (value) {
                              setState(() {
                                switchValues[index] = switchValues[index]
                                    .copyWith(isActive: value);
                              });
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
            ),
            Positioned(
              bottom: 20,
              right: 20,
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
          ],
        ),
      ),
    );
  }
}

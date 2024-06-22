import 'package:english_learner/main.dart';
import 'package:english_learner/models/achievement.dart';
import 'package:english_learner/presentations/dialog/customDialog/loading_dialog.dart';
import 'package:flutter/material.dart';

import 'customDialog/add_achievement_dialog.dart';
import 'customDialog/alert_achievement.dart';

class CustomDialog {
  static void showLoadingDialog() {
    showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          content: LoadingDialog(),
        );
      },
    );
  }

  static Future<Achievement?> showAddAchiementDialog() async {
    return await showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      builder: (context) {
        return const AlertDialog(
          contentPadding: EdgeInsets.all(0),
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: AddAchievementDialog(),
          ),
        );
      },
    ).then((value) {
      return value;
    });
  }

  static void showAlertAchievementDialog(Achievement achievement) {
    showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: AlertAchievement(
              achievement: achievement,
            ),
          ),
        );
      },
    );
  }

  static void hide() {
    Navigator.of(navigatorKey.currentState!.overlay!.context).pop();
  }
}

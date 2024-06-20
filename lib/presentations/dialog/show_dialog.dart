import 'package:english_learner/models/achievement.dart';
import 'package:english_learner/presentations/dialog/customDialog/loading_dialog.dart';
import 'package:flutter/material.dart';

import 'customDialog/add_achievement_dialog.dart';

class CustomDialog {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
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

  static Future<Achievement?> showAddAchiementDialog(BuildContext ctx) async {
    return await showDialog(
      context: ctx,
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

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}

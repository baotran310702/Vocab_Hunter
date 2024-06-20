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

  static void showAddAchiementDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (context) {
        return const AlertDialog(
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          content: AddAchievementDialog(),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}

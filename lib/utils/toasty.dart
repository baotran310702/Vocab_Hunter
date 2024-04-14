import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasty {
  showToast(String msg, BuildContext context) {
    FToast toasty = FToast();
    toasty.init(context);
    toasty.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Wrap(
          children: [
            Image.asset(
              AppIcons.logo,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 16),
            Text(
              msg,
              style: const TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(milliseconds: 1200),
    );
  }
}

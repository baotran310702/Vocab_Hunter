import 'package:english_learner/presentations/global_widgets/appbar.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool isMan = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(text: 'Secuity Informations'),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.backgroundHeader,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppIcons.security, width: 120, height: 120),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Change Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const CustomTextField(
              hintText: "Old Password",
              icon: AppIcons.security,
              isPassword: true,
            ),
            const SizedBox(
              height: 16,
            ),
            const CustomTextField(
              hintText: "New Password",
              icon: AppIcons.security,
              isPassword: true,
            ),
            const SizedBox(
              height: 16,
            ),
            const CustomTextField(
              hintText: "Re-Write New Password",
              icon: AppIcons.security,
              isPassword: true,
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(
                  MediaQuery.of(context).size.width * 0.9,
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
              onPressed: () {},
              child: const Text(
                "SAVE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _changeGener(value) {
    setState(() {
      isMan = !isMan;
    });
  }
}

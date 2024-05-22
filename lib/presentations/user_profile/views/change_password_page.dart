import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/user_profile/bloc/manage_user_bloc.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool isMan = true;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reWriteNewPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageUserProfileBloc, ManageUserState>(
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      child: Scaffold(
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
              CustomTextField(
                hintText: "New Password",
                icon: AppIcons.security,
                isPassword: true,
                controller: newPasswordController,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                hintText: "Re-Write New Password",
                icon: AppIcons.security,
                isPassword: true,
                controller: reWriteNewPasswordController,
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
                onPressed: () {
                  if (newPasswordController.text ==
                          reWriteNewPasswordController.text &&
                      newPasswordController.text.isNotEmpty) {
                    context.read<ManageUserProfileBloc>().add(
                          UpdateNewPassWord(
                            newPassWord: newPasswordController.text,
                          ),
                        );
                  } else {}
                },
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
      ),
    );
  }
}

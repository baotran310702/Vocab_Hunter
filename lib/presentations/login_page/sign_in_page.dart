//create a login page

import 'package:english_learner/presentations/login_page/widgets/custom_button.dart';
import 'package:english_learner/services/user_services.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widgets/input_text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            //text form field to enter email
            InputTextFields(
              textController: emailController,
              hintText: "Tên đăng nhập/Gmail",
              labelText: "Tên đăng nhập/Gmail",
            ),

            const SizedBox(height: 12),

            InputTextFields(
              textController: passwordController,
              hintText: "Mật khẩu",
              labelText: "Mật khẩu",
            ),

            //text form field to enter password

            const SizedBox(height: 12),

            Row(
              children: [
                Text(
                  "Quên mật khẩu?",
                  style: TextStyle(
                    color: AppColors.textColors,
                  ),
                ),
                Text(
                  " Nhấn vào đây",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColors,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            //buttom submit
            CustomButton(
              backgroundColor: AppColors.primaryBackgroundButton,
              text: Text(
                "Đăng nhập",
                style: TextStyle(
                  color: AppColors.primaryTextButton,
                ),
              ),
              onPressed: () async {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Vui lòng nhập đầy đủ thông tin",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {}
              },
            )
          ],
        ),
      ),
    );
  }
}

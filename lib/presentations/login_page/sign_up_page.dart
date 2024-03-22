//create a sign up page

import 'package:english_learner/gen/assets.gen.dart';
import 'package:english_learner/presentations/login_page/widgets/custom_button.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widgets/input_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: AppColors.mainBackgroundColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icons.logo.image(
                  width: 600,
                  height: 300,
                ),
                const SizedBox(
                  height: 20,
                ),
                //text form field to enter email
                InputTextFields(
                  textController: emailController,
                  hintText: "Nhập gmail của bạn...",
                  labelText: "Gmail",
                ),

                const SizedBox(height: 12),

                InputTextFields(
                  textController: passwordController,
                  hintText: "Nhập tên đăng nhập...",
                  labelText: "Tên đăng nhập",
                ),

                //text form field to enter password

                const SizedBox(height: 12),

                InputTextFields(
                  textController: passwordController,
                  hintText: "******************",
                  labelText: "Nhập mật khẩu của bạn",
                ),

                const SizedBox(height: 12),
                InputTextFields(
                  textController: passwordController,
                  hintText: "******************",
                  labelText: "Nhập lại mật khẩu của bạn",
                ),

                const SizedBox(height: 30),

                //buttom submit
                CustomButton(
                  backgroundColor: AppColors.primaryBackgroundButton,
                  text: Text(
                    "Đăng ký",
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
                ),

                const SizedBox(height: 12),
                Text(
                  "- Or -",
                  style: TextStyle(
                    color: AppColors.textColors,
                  ),
                ),
                const SizedBox(height: 12),

                CustomButton(
                  backgroundColor: AppColors.secondaryBackgroundButton,
                  text: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.google.image(width: 20, height: 20),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Đăng nhập bằng Google",
                        style: TextStyle(
                          color: AppColors.secondaryTextButton,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Bạn đã có tài khoản?"),
                  const SizedBox(
                    width: 4,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/",
                        (Route<dynamic> route) => route.isFirst,
                      );
                    },
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColors,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

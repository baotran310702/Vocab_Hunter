import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/icons.dart';
import 'bloc/authentication_bloc.dart';
import 'widgets/custom_button.dart';
import 'widgets/input_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController retypePasswordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.error == null && state.success != null) {
            Navigator.pushReplacementNamed(context, "/home");
          }
          if (state.error != null && state.success == null ||
              state.isLoading == false) {
            Fluttertoast.showToast(
              msg: state.error ?? "Đăng ký thất bại",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: AppColors.backgroundHeader,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppIcons.logo,
                              width: 300,
                              height: 300,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //text form field to enter email
                            InputTextFields(
                              isPassword: false,
                              textController: emailController,
                              hintText: "Nhập email của bạn...",
                              labelText: "Email",
                            ),

                            const SizedBox(height: 12),

                            InputTextFields(
                              isPassword: false,
                              textController: userNameController,
                              hintText: "Nhập tên của bạn...",
                              labelText: "Tên người dùng",
                            ),

                            //text form field to enter password

                            const SizedBox(height: 12),

                            InputTextFields(
                              isPassword: true,
                              textController: passwordController,
                              hintText: "******************",
                              labelText: "Nhập mật khẩu của bạn",
                            ),

                            const SizedBox(height: 12),
                            InputTextFields(
                              isPassword: true,
                              textController: retypePasswordController,
                              hintText: "******************",
                              labelText: "Nhập lại mật khẩu của bạn",
                            ),

                            const SizedBox(height: 30),

                            //buttom submit
                            CustomButton(
                              backgroundColor: AppColors.textInputs,
                              text: Text(
                                "Đăng ký",
                                style: TextStyle(
                                  color: AppColors.primaryTextButton,
                                ),
                              ),
                              onPressed: () async {
                                if (emailController.text.isEmpty ||
                                    passwordController.text.isEmpty ||
                                    userNameController.text.isEmpty ||
                                    retypePasswordController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "Vui lòng nhập đầy đủ thông tin",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                  return;
                                }
                                if (retypePasswordController.text !=
                                    passwordController.text) {
                                  Fluttertoast.showToast(
                                    msg: "Mật khẩu không khớp",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                  return;
                                }
                                context.read<AuthenticationBloc>().add(
                                      Register(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        userName: userNameController.text,
                                      ),
                                    );
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
                              backgroundColor: AppColors.achievedSlider,
                              text: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppIcons.google,
                                    width: 24,
                                    height: 24,
                                  ),
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
                                      (Route<dynamic> route) => route.isFirst);
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
        },
      ),
    );
  }
}

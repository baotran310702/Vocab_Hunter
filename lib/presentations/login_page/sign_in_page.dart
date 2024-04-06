import 'package:english_learner/presentations/login_page/bloc/authentication_bloc.dart';
import 'package:english_learner/presentations/login_page/widgets/custom_button.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/icons.dart';
import 'widgets/input_text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => AuthenticationBloc()..add(AuthWithToken()),
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.isLoading) {
            return;
          }
          if (state.success != null && state.error == null) {
            Navigator.pushReplacementNamed(context, "/home");
          }
          if (state.error != null &&
              state.success == null &&
              state.isLoading == false) {
            Fluttertoast.showToast(
              msg: state.success ?? "Đăng nhập thất bại!",
              toastLength: Toast.LENGTH_LONG,
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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                        children: [
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
                                textController: emailController,
                                hintText: "Tên đăng nhập/Gmail",
                                labelText: "Tên đăng nhập/Gmail",
                                isPassword: false,
                              ),

                              const SizedBox(height: 12),

                              InputTextFields(
                                textController: passwordController,
                                hintText: "Mật khẩu",
                                labelText: "Mật khẩu",
                                isPassword: true,
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

                              const SizedBox(height: 30),

                              //buttom submit
                              CustomButton(
                                backgroundColor: AppColors.textInputs,
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
                                  } else {
                                    context.read<AuthenticationBloc>().add(
                                          Login(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ),
                                        );
                                  }
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
                                const Text("Bạn chưa có tài khoản?"),
                                const SizedBox(
                                  width: 4,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, "/sign-up");
                                  },
                                  child: Text(
                                    "Đăng ký",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textColors,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

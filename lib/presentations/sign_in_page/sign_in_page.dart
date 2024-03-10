//create a login page

import 'package:english_learner/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //text form field to enter email
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
            ),
          ),

          //text form field to enter password
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
            ),
          ),

          //buttom submit
          ElevatedButton(
            onPressed: () async {
              UserServices services = UserServices();
              try {
                await services
                    .signIn(emailController.text, passwordController.text)
                    .then((value) => Navigator.pushNamedAndRemoveUntil(
                        context, "/home", (route) => false));
              } catch (e) {
                Fluttertoast.showToast(
                    msg: "Tên đăng nhập hoặc mật khẩu không đúng!");
              }
            },
            child: const Text("Sign in"),
          ),

          //buttom submit
          ElevatedButton(
            onPressed: () async {
              UserServices services = UserServices();
              try {
                await services
                    .signUp(emailController.text, passwordController.text)
                    .then((value) => Navigator.pushNamedAndRemoveUntil(
                        context, "/home", (route) => false));
              } catch (e) {
                Fluttertoast.showToast(
                    msg: "Tên đăng nhập hoặc mật khẩu không đúng !$e");
              }
            },
            child: const Text("Sign up"),
          ),
        ],
      ),
    );
  }
}

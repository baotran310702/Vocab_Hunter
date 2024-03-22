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
            onPressed: () async {},
            child: const Text("Sign up"),
          ),
        ],
      ),
    );
  }
}

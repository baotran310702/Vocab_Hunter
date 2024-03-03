//create a login page

import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => Navigator.pushNamed(context, '/home'),
        child: const Center(
          child: Text('Sign In Page'),
        ),
      ),
    );
  }
}

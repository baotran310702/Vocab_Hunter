import 'package:english_learner/models/user.dart';
import 'package:english_learner/services/user_hive_local.dart';
import 'package:flutter/material.dart';

class UserTest extends StatefulWidget {
  const UserTest({super.key});

  @override
  State<UserTest> createState() => _UserTestState();
}

class _UserTestState extends State<UserTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Test'),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.amber,
          child: Column(
            children: [
              const Text('User Test'),
              ElevatedButton(
                  onPressed: handleLocal, child: const Text("okokokoko"))
            ],
          ),
        ),
      ),
    );
  }

  handleLocal() async {
    UserHiveLocal().saveUser(UserModel.initWithId(
      '1',
      'John Doe',
    ));
  }
}

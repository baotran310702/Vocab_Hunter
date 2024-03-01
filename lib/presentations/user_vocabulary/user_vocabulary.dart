import 'package:flutter/material.dart';

class UserVocabulary extends StatelessWidget {
  const UserVocabulary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Container(
        color: Colors.green,
        child: const Center(
          child: Text('Vocabulary Page'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Container(
        color: Colors.amber,
        child: const Center(
          child: Text('Dictionary Page'),
        ),
      ),
    );
  }
}

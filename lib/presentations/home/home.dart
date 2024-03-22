import 'package:english_learner/presentations/home/widgets/box_list_vocab_type.dart';
import 'package:english_learner/presentations/home/widgets/header_informations.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HeaderInformations(),
                Text(
                  'Welcome to English Learner',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                ListVocabType(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

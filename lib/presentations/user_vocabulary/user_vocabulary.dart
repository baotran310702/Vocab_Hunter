import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

import '../home/widgets/header_informations.dart';

class UserVocabularyTrain extends StatefulWidget {
  const UserVocabularyTrain({super.key});

  @override
  State<UserVocabularyTrain> createState() => _UserVocabularyTrainState();
}

class _UserVocabularyTrainState extends State<UserVocabularyTrain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAppbar,
      body: SafeArea(
          child: Container(
        color: AppColors.backgroundHeader,
        child: const Column(
          children: [
            HeaderInformations(
              title: "User Information",
            ),
          ],
        ),
      )),
    );
  }
}

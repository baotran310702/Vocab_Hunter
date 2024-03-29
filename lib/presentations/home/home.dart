import 'package:english_learner/presentations/home/widgets/box_list_vocab_type.dart';
import 'package:english_learner/presentations/home/widgets/box_news.dart';
import 'package:english_learner/presentations/home/widgets/box_vocab_item.dart';
import 'package:english_learner/presentations/home/widgets/header_informations.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> listNews = [1, 2, 3, 4];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAppbar,
      extendBody: true,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: AppColors.backgroundHeader,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderInformations(
                  title: "Welcome back Kevin",
                  description: "Let's learn something new today",
                ),
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ListVocabType(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      "Daily Vocabulary",
                      style: TextStyle(
                        color: AppColors.titleHeaderColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i in list)
                        BoxVocab(
                          key: Key(
                            i.toString(),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      "News Recommended for You",
                      style: TextStyle(
                        color: AppColors.titleHeaderColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    for (int i in listNews)
                      BoxNews(
                        key: Key(
                          i.toString(),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

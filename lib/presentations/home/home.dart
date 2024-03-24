import 'package:english_learner/presentations/home/widgets/box_list_vocab_type.dart';
import 'package:english_learner/presentations/home/widgets/box_news.dart';
import 'package:english_learner/presentations/home/widgets/box_vocab_item.dart';
import 'package:english_learner/presentations/home/widgets/header_informations.dart';
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
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderInformations(
                  title: "Welcome back KICM",
                ),
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ListVocabType(),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      "Daily Vocabulary",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
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
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      "News Recommended for You",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
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

import 'package:english_learner/models/news.dart';
import 'package:english_learner/presentations/home/bloc/home_page_bloc.dart';
import 'package:english_learner/presentations/home/widgets/box_list_vocab_type.dart';
import 'package:english_learner/presentations/home/widgets/box_news.dart';
import 'package:english_learner/presentations/home/widgets/box_vocab_item.dart';
import 'package:english_learner/presentations/home/widgets/header_informations.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc()..add(HomePageInitialEvent()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundHeader,
        extendBody: true,
        body: PopScope(
          canPop: false,
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: AppColors.backgroundHeader,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<HomePageBloc, HomePageState>(
                      builder: (context, state) {
                        return HeaderInformations(
                          title: "Welcome back ${state.currentUser.userName}",
                          description: "Let's learn something new today",
                        );
                      },
                    ),
                    const SizedBox(height: 20),
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
                    BlocBuilder<HomePageBloc, HomePageState>(
                      builder: (context, state) {
                        if (state.isLoading ||
                            state.currentRecommendWords == null) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.achievedSlider,
                            ),
                          );
                        }
                        if (state.currentRecommendWords!.isEmpty) {
                          return const Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              "No words recommends, please check your list words if it's empty.",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ));
                        }
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0;
                                  i < state.currentRecommendWords!.length;
                                  i++)
                                BoxVocab(
                                  key: Key(
                                    i.toString(),
                                  ),
                                  englishVocabulary:
                                      state.currentRecommendWords![i].$1,
                                  vietnameseVocabulary:
                                      state.currentRecommendWords![i].$2,
                                ),
                            ],
                          ),
                        );
                      },
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
                    BlocBuilder<HomePageBloc, HomePageState>(
                      builder: (context, state) {
                        List<News> listNews = state.news;

                        return Column(
                          children: [
                            for (News i in listNews)
                              BoxNews(
                                key: UniqueKey(),
                                news: i,
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

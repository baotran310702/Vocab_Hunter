import 'package:english_learner/presentations/dictionary_page/bloc/translate_page_bloc.dart';
import 'package:english_learner/presentations/home/widgets/back_button.dart';
import 'package:english_learner/presentations/home/widgets/box_vocab_item.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailVocabulary extends StatefulWidget {
  final TranslatePageBloc? translatePageBloc;
  const DetailVocabulary({super.key, this.translatePageBloc});

  @override
  State<DetailVocabulary> createState() => _DetailVocabularyState();
}

class _DetailVocabularyState extends State<DetailVocabulary>
    with TickerProviderStateMixin {
  final PageController _pageViewController = PageController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    return BlocProvider(
      create: (context) => TranslatePageBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Default vocab"),
          leading: const ButtonBack(),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: "Vietnamese - English",
              ),
              Tab(
                text: "English - English",
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: [
              DetailVocabularyPage(list: list),
              DetailVocabularyPage(list: list),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailVocabularyPage extends StatelessWidget {
  const DetailVocabularyPage({
    super.key,
    required this.list,
  });

  final List<int> list;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Default Vocabulary",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "/default phonetic/",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(AppIcons.speaker, width: 28, height: 28),
                ],
              ),
              const Devider(),
              const BoxMeaning(),
              const SizedBox(height: 40),
              const BoxMeaning(),
              const SizedBox(height: 40),
              const BoxMeaning(),
              const SizedBox(height: 40),
              const Text(
                "Synonyms",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 40),
              const Text(
                "Atonyms",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxMeaning extends StatelessWidget {
  const BoxMeaning({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 160,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: const Center(child: Text("Noun")),
        ),
        const SizedBox(height: 10),
        const Text(
          "Meaning: default meaning",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            Image.asset(
              AppIcons.bell,
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              "default example",
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Devider extends StatelessWidget {
  const Devider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: 1,
      color: Colors.black,
    );
  }
}

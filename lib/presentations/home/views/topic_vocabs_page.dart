import 'package:english_learner/presentations/global_instance/loading.dart';
import 'package:english_learner/presentations/home/widgets/back_button.dart';
import 'package:english_learner/presentations/home/widgets/list_topics_vocab.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_page_bloc.dart';

class TopicVocab extends StatefulWidget {
  const TopicVocab({super.key});

  @override
  State<TopicVocab> createState() => _TopicVocabState();
}

class _TopicVocabState extends State<TopicVocab> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc()..add(InitTopicVocabulary()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Topic Vocab'),
          leading: const ButtonBack(),
        ),
        body: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.backgroundHeader,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: state.listTopicVocab.isEmpty
                      ? [
                          const Center(
                            child: LoadingPage(message: "Downloading Topic..."),
                          )
                        ]
                      : state.listTopicVocab
                          .map(
                            (e) => ListTopicVocab(
                              topic: e,
                            ),
                          )
                          .toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

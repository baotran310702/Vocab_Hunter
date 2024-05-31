import 'package:english_learner/models/sub_topic.dart';
import 'package:english_learner/models/vocabulary/vocab_translated_local.dart';
import 'package:english_learner/models/vocabulary_topic/vocabulary_topic.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/home/bloc/home_page_bloc.dart';
import 'package:english_learner/presentations/home/widgets/vocabulary_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dictionary_page/views/detail_vocabulary.dart';

class ListVocabTopicItem extends StatefulWidget {
  final SubTopic subTopic;

  const ListVocabTopicItem({super.key, required this.subTopic});

  @override
  State<ListVocabTopicItem> createState() => _ListVocabTopicItemState();
}

class _ListVocabTopicItemState extends State<ListVocabTopicItem> {
  @override
  Widget build(BuildContext context) {
    List<VocabularyByTopic> currentVocabEnglishList = [];

    return BlocProvider(
      create: (context) => HomePageBloc()..add(InitDetailTopicVocabulary()),
      child: Scaffold(
        appBar: MyAppbar(
          text: widget.subTopic.name.toUpperCase(),
        ),
        body: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is DetailVocabTopicState) {
              for (var item in state.listSubTopicItemLocal) {
                if (item.topic.trim().toLowerCase() ==
                    widget.subTopic.name.trim().toLowerCase()) {
                  currentVocabEnglishList = List.from(item.vocabularyByTopic);
                  break;
                }
              }
            }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  for (int i = 0; i < currentVocabEnglishList.length; i++)
                    Column(
                      children: [
                        VocabularyItem(
                          vocabularyByTopic: currentVocabEnglishList[i],
                          onTap: () => {},
                        ),
                        Container(
                          color: Colors.black54,
                          height: 1,
                          width: MediaQuery.of(context).size.width * 0.9,
                        )
                      ],
                    ),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onTapVocabItem(BuildContext context, VocabTranslatedLocalModel vocab) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailVocabulary(
          vocabTranslatedLocal: vocab,
        ),
      ),
    );
  }
}

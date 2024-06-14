import 'package:english_learner/models/sub_topic.dart';
import 'package:english_learner/presentations/home/bloc/home_page_bloc.dart';
import 'package:english_learner/presentations/home/widgets/back_button.dart';
import 'package:english_learner/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/box_topic_detail.dart';

class ListDetailTopicVocab extends StatefulWidget {
  final List<SubTopic> listSubtopics;
  final String nameTopic;
  const ListDetailTopicVocab({
    super.key,
    required this.listSubtopics,
    required this.nameTopic,
  });

  @override
  State<ListDetailTopicVocab> createState() => _LisDetailtTopicVocabState();
}

class _LisDetailtTopicVocabState extends State<ListDetailTopicVocab> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc()..add(InitDetailTopicVocabulary()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.nameTopic),
          leading: const ButtonBack(),
        ),
        body: PageContent(
          subTopics: widget.listSubtopics,
          topicId: widget.nameTopic,
        ),
      ),
    );
  }
}

class PageContent extends StatefulWidget {
  final String topicId;
  final List<SubTopic> subTopics;
  const PageContent({
    super.key,
    required this.subTopics,
    required this.topicId,
  });

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  List<(DownloadStatus, SubTopic)> statusTopic = [];

  @override
  Widget build(BuildContext context) {
    double boxHeight = 400;
    double radius = 20;
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is DetailVocabTopicState) {
          statusTopic.clear();
          for (var item in widget.subTopics) {
            int indx = state.listSubTopicItemLocal.indexWhere((element) =>
                element.topic.trim().toLowerCase() ==
                item.name.trim().toLowerCase());
            if (indx != -1) {
              statusTopic.add((DownloadStatus.downloaded, item));
              continue;
            }
            statusTopic.add((DownloadStatus.notDownloaded, item));
          }
          // sort status topic
          statusTopic.sort((a, b) {
            if (a.$1 == DownloadStatus.downloaded) {
              return -1;
            }
            return 1;
          });
        }
        return Container(
          padding: const EdgeInsets.all(14),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xffe0e0e0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: statusTopic
                  .map((e) => BoxTopicDetail(
                        boxHeight: boxHeight,
                        radius: radius,
                        subTopic: e.$2,
                        handleLoadTopic: _handleLoadTopic,
                        downLoadStatus: e.$1,
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  _handleLoadTopic(String subTopicId) async {
    //update status to downloading subtopic
    int indx = statusTopic.indexWhere((element) =>
        element.$2.name.trim().toLowerCase() ==
        subTopicId.trim().toLowerCase());
    if (indx != -1) {
      statusTopic[indx] = (DownloadStatus.dowloading, statusTopic[indx].$2);
    }

    setState(() {});

    context.read<HomePageBloc>().add(
          DownLoadDetailTopicVocab(
            subTopicId: subTopicId,
            topicId: widget.topicId,
          ),
        );
  }
}

import 'package:english_learner/models/sub_topic.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/home/widgets/box_topic_detail.dart';
import 'package:english_learner/utils/enum.dart';
import 'package:flutter/material.dart';

class DetailFavouriteVocabPage extends StatefulWidget {
  final SubTopic subTopic;
  const DetailFavouriteVocabPage({super.key, required this.subTopic});

  @override
  State<DetailFavouriteVocabPage> createState() =>
      _DetailFavouriteVocabPageState();
}

class _DetailFavouriteVocabPageState extends State<DetailFavouriteVocabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(text: widget.subTopic.name),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BoxTopicDetail(
            subTopic: widget.subTopic,
            boxHeight: MediaQuery.of(context).size.height / 2.4,
            radius: 24,
            handleLikeSubTopic: handleLikeSubTopic,
            handleLoadTopic: handleLoadTopic,
            downLoadStatus: DownloadStatus.downloaded,
          ),
        ),
      )),
    );
  }

  handleLikeSubTopic(SubTopic subTopicId) {}
  handleLoadTopic(String subTopicId) {}
}

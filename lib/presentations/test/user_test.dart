import 'package:english_learner/models/sub_topic.dart';
import 'package:english_learner/models/time_notification.dart';
import 'package:english_learner/models/topic.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/models/vocabulary_topic/list_vocabulary_topic.dart';
import 'package:english_learner/models/vocabulary_topic/vocabulary_topic.dart';
import 'package:english_learner/services/excel_service.dart';
import 'package:english_learner/services/gemini_services.dart';
import 'package:english_learner/services/time_notification_local.dart';
import 'package:english_learner/services/topic_vocab_service.dart';
import 'package:english_learner/services/user_hive_local.dart';
import 'package:english_learner/services/word_notification_local.dart';
import 'package:flutter/material.dart';

import '../../models/vocabulary/vocab_topic.dart';
import '../../models/word_notification.dart';

class UserTest extends StatefulWidget {
  const UserTest({super.key});

  @override
  State<UserTest> createState() => _UserTestState();
}

class _UserTestState extends State<UserTest> {
  bool isLoading = false;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await TimeNotificationLocal().init();
    await WordNotificationServices().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Test'),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.amber,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const Text('Save Data User'),
                ElevatedButton(
                  onPressed: handleLocal,
                  child: const Text("okokokoko"),
                ),
                const Text('Get Data'),
                ElevatedButton(
                  onPressed: getDataLocal,
                  child: const Text("Lowg"),
                ),
                const Text('Update Data to WordNotification'),
                ElevatedButton(
                  onPressed: getDataLocal,
                  child: const Text("Lowg"),
                ),
                const Text('Get Words Local'),
                ElevatedButton(
                  onPressed: getWordsLocal,
                  child: const Text("Get All Words from Loca"),
                ),
                const Text('Get Words Local'),
                ElevatedButton(
                  onPressed: getNWordsLocal,
                  child: const Text("get n words local"),
                ),
                const Text('24h'),
                ElevatedButton(
                  onPressed: set24hLocal,
                  child: const Text("Set 24h minnutes test local"),
                ),
                const Text('clear 24h'),
                ElevatedButton(
                  onPressed: clear24hLocal,
                  child: const Text(""),
                ),
                const Text('Update Data to Firebase'),
                ElevatedButton(
                  onPressed: firebaseUpdate,
                  child: const Text("Update Vocabulary to Firebase"),
                ),
                const Text('Update Data TOEIC to Firebase'),
                ElevatedButton(
                  onPressed: firebaseUpdateToeic,
                  child: const Text(
                      "Update Vocabulary TOEIC to Firebase okokokokoko"),
                ),
                const Text('TOPIC Vocabularyyyy'),
                ElevatedButton(
                  onPressed: firebaseUpdateTopic,
                  child: const Text("'TOPIC Vocabularyyy"),
                ),
                const Text(''),
                ElevatedButton(
                  onPressed: firebaseUpdateTopic,
                  child: const Text("'get topic data"),
                ),
                const Text('Update Topic Vocabulary'),
                ElevatedButton(
                  onPressed: testGeminiVocabTopicDescirption,
                  child: const Text("Test Gemini"),
                ),
                const Text('Update amout topiccc'),
                ElevatedButton(
                  onPressed: updateAmountWordsTopicVocab,
                  child: const Text("Update amounttttttt newsest topic"),
                ),
                ElevatedButton(
                  onPressed: renameField,
                  child: const Text("Renameee topic vocabbb"),
                ),
                if (isLoading) const CircularProgressIndicator(),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  testGeminiVocabTopicDescirption() async {
    setState(() {
      isLoading = true;
    });

    List<SubTopic> listTopics = [];
    for (int i = 0; i < 30; i++) {
      listTopics.add(
        SubTopic(
          name: "Part $i",
          subTopicId: "part $i",
          image:
              "https://sununi.edu.vn/wp-content/uploads/2023/08/hoc-toeic-hay-ielts-2.jpg",
          description: "Part $i of TOEIC vocabulary.",
          amountVocab: 0,
          isLiked: false,
        ),
      );
    }

    for (var item in listTopics) {
      debugPrint(item.description);
    }

    await TopicVocabServices().updateSubTopicVocab(listTopics, "toeic");
    setState(() {
      isLoading = false;
    });
  }

  updateListSubTopic(List<SubTopic> listTopics) async {
    GeminiServices services = GeminiServices();
    for (SubTopic topic in listTopics) {
      String description = await services.getDescriptionTopic(topic.name);
      topic.description = description;
    }
  }

  updateAmountWordsTopicVocab() async {
    TopicVocabServices services = TopicVocabServices();
    List<Topic> list = await services.getAllTopicVocab();

    for (var item in list) {
      if (item.name.toLowerCase() != 'topic') continue;
      List<ListVocabularyTopic> listVocabTopic =
          await services.getListVocabularyTopic(item.topicId);
      for (SubTopic subTopic in item.subTopics) {
        for (ListVocabularyTopic vocabTopic in listVocabTopic) {
          if (vocabTopic.topic.toLowerCase().trim() ==
              subTopic.name.toLowerCase().trim()) {
            subTopic.amountVocab = vocabTopic.vocabularyByTopic.length;
          }
        }
      }
    }

    List<Topic> newTopics = list;
    //update subtopic
    for (Topic topic in newTopics) {
      await services.updateSubTopicVocab(topic.subTopics, topic.topicId);
    }
  }

  firebaseUpdateTopicVocabulary() async {
    ExcelService excelServices = ExcelService();
    List<VocabTopic> listVocab = await excelServices.getTopicVocab();
    //cate gory listVocab by topic
    Map<String, List<VocabTopic>> map = {};
    for (var item in listVocab) {
      if (map.containsKey(item.topic)) {
        map[item.topic]!.add(item);
      } else {
        map[item.topic] = [item];
      }
    }
  }

  firebaseGetUserTopicVocab() async {
    TopicVocabServices services = TopicVocabServices();
    List<Topic> list = await services.getAllTopicVocab();
    debugPrint(list.length.toString());
  }

  firebaseUpdateTopic() async {
    ExcelService excelServices = ExcelService();
    List<VocabTopic> listVocab = await excelServices.getTopicVocab();
    //cate gory listVocab by topic
    Map<String, List<VocabTopic>> map = {};
    for (var item in listVocab) {
      if (map.containsKey(item.topic)) {
        map[item.topic]!.add(item);
      } else {
        map[item.topic] = [item];
      }
    }

    await excelServices.updateTopicVocabFbByTopicNotIelts(map);
  }

  firebaseUpdateToeic() async {
    ExcelService excelServices = ExcelService();
    List<VocabTopic> listVocab = await excelServices.getVocabLocal();

    await excelServices.updateToeicVocabFirebase(listVocab);
  }

  firebaseUpdate() async {
    ExcelService excelServices = ExcelService();
    List<VocabularyByTopic> listVocab = await excelServices.getIeltsVocab();
    //cate gory listVocab by topic
    Map<String, List<VocabularyByTopic>> map = {};
    for (var item in listVocab) {
      if (map.containsKey(item.topic)) {
        map[item.topic]!.add(item);
      } else {
        map[item.topic] = [item];
      }
    }
    // await excelServices.updateTopicVocabFirebase(map);
  }

  clear24hLocal() async {
    await TimeNotificationLocal().clearListNotification();
  }

  set24hLocal() async {
    //create 24h time of day from each minutes
    List<TimeOfDay> list = [];
    for (int i = 0; i < 24; i++) {
      for (int j = 0; j < 60; j++) {
        list.add(TimeOfDay(hour: i, minute: j));
      }
    }

    ListTimeNotification listTimeNotification = ListTimeNotification(
      listTimeNotification: list
          .map((e) => TimeNotification(
                id: list.indexOf(e),
                time: e,
                isActive: true,
              ))
          .toList(),
    );

    await TimeNotificationLocal().updateListNotification(listTimeNotification);

    ListTimeNotification listTimeNotification2 =
        await TimeNotificationLocal().getListTimeNotification();

    for (var item in listTimeNotification2.listTimeNotification) {
      debugPrint(item.time.toString());
    }
  }

  testChunks() async {
    List<int> list = List.generate(100, (index) => index);
    int numChunk = 15;
    // Tính toán kích thước của mỗi mảng con
    int chunkSize = (list.length / numChunk).ceil();

    List<List<int>> chunks = [];

    for (int i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(
          i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
  }

  getWordsLocal() async {
    ListWordNotification listWordNotification =
        await WordNotificationServices().getListWordNotification();
    List<WordNotification> list = listWordNotification.listWordNotification;

    for (var item in list) {
      debugPrint(item.englishWords.word);
    }
  }

  handleLocal() async {
    UserHiveLocal().saveUser(UserModel.defaultInit());
  }

  getNWordsLocal() async {
    ListWordNotification listWordNotification =
        await WordNotificationServices().getNWordNotificationLocal(10);
    List<WordNotification> list = listWordNotification.listWordNotification;

    for (var item in list) {
      debugPrint(item.englishWords.word);
    }
  }

  renameField() async {
    TopicVocabServices topicVocabServices = TopicVocabServices();
    setState(() {
      isLoading = true;
    });
    await topicVocabServices.renameFieldVocabulary();
    setState(() {
      isLoading = false;
    });
  }

  getDataLocal() async {
    UserModel user = await UserHiveLocal().getUser();
    List<WordNotification> wordNotification = [];

    Map<String, List<VocabularyRemote>> map =
        user.learningWords.first.listVocabulary;
    List<VocabularyRemote> list = map['english'] is List<VocabularyRemote>
        ? map['english'] as List<VocabularyRemote>
        : [];
    List<VocabularyRemote> list2 = map['translated'] is List<VocabularyRemote>
        ? map['translated'] as List<VocabularyRemote>
        : [];

    for (int i = 0; i < list.length; i++) {
      wordNotification.add(WordNotification(
        englishWords: list.elementAt(i),
        vietnameseWords: list2.elementAt(i),
        failureCount: 0,
        successCount: 0,
        thresholdWords: ThresholdWords.mediumFailure,
      ));
    }

    ListWordNotification listWordNotification = ListWordNotification(
      listWordNotification: wordNotification,
    );

    await WordNotificationServices()
        .updateListWordNotification(listWordNotification);
  }
}

import 'package:english_learner/models/time_notification.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/services/time_notification_local.dart';
import 'package:english_learner/services/user_hive_local.dart';
import 'package:english_learner/services/word_notification_local.dart';
import 'package:flutter/material.dart';

import '../../models/word_notification.dart';

class UserTest extends StatefulWidget {
  const UserTest({super.key});

  @override
  State<UserTest> createState() => _UserTestState();
}

class _UserTestState extends State<UserTest> {
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
            ],
          ),
        ),
      ),
    );
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

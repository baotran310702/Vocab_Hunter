import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/models/word_notification.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// This class was created for the purpose of managing the word notification data locally.
class WordNotificationServices {
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);

    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveEnumWordNoti)) {
      Hive.registerAdapter(ThresholdWordsAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveWordNoti)) {
      Hive.registerAdapter(WordNotificationAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListwordNotificationId)) {
      Hive.registerAdapter(ListWordNotificationAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveVocabRemote)) {
      Hive.registerAdapter(VocabularyRemoteAdapter());
    }
  }

  Future<void> updateListWordNotification(
      ListWordNotification listWordNotification) async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveEnumWordNoti)) {
      Hive.registerAdapter(ThresholdWordsAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveWordNoti)) {
      Hive.registerAdapter(WordNotificationAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListwordNotificationId)) {
      Hive.registerAdapter(ListWordNotificationAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveVocabRemote)) {
      Hive.registerAdapter(VocabularyRemoteAdapter());
    }
    final box = await Hive.openBox<ListWordNotification>(
        KeyBoxHiveLocal.listWordNotificationKeyBox);
    await box.put(
        KeyBoxHiveLocal.listWordNotificationKeyBox, listWordNotification);
  }

  Future<ListWordNotification> getListWordNotification() async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveEnumWordNoti)) {
      Hive.registerAdapter(ThresholdWordsAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveWordNoti)) {
      Hive.registerAdapter(WordNotificationAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveVocabRemote)) {
      Hive.registerAdapter(VocabularyRemoteAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListwordNotificationId)) {
      Hive.registerAdapter(ListWordNotificationAdapter());
    }

    if (!Hive.isAdapterRegistered(KeyHiveLocal.hivePhonestic)) {
      Hive.registerAdapter(PhoneticsAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveMeanings)) {
      Hive.registerAdapter(MeaningsAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveDefinitions)) {
      Hive.registerAdapter(DefinitionsAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveLiences)) {
      Hive.registerAdapter(LicenseAdapter());
    }

    final box = await Hive.openBox<ListWordNotification>(
        KeyBoxHiveLocal.listWordNotificationKeyBox);
    ListWordNotification result =
        box.get(KeyBoxHiveLocal.listWordNotificationKeyBox) ??
            ListWordNotification.empty();

    return result;
  }

  Future<void> updateWordNotification(WordNotification wordNotification) async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveEnumWordNoti)) {
      Hive.registerAdapter(ThresholdWordsAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveWordNoti)) {
      Hive.registerAdapter(WordNotificationAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListwordNotificationId)) {
      Hive.registerAdapter(ListWordNotificationAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveVocabRemote)) {
      Hive.registerAdapter(VocabularyRemoteAdapter());
    }
    final box = await Hive.openBox<ListWordNotification>(
        KeyBoxHiveLocal.listWordNotificationKeyBox);
    ListWordNotification listWordNotification =
        box.get(KeyBoxHiveLocal.listWordNotificationKeyBox) ??
            ListWordNotification.empty();
    listWordNotification.listWordNotification.add(wordNotification);
    await box.put(
        KeyBoxHiveLocal.listWordNotificationKeyBox, listWordNotification);
  }

  Future<void> removeWordNotification(WordNotification wordNotification) async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveEnumWordNoti)) {
      Hive.registerAdapter(ThresholdWordsAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveWordNoti)) {
      Hive.registerAdapter(WordNotificationAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListwordNotificationId)) {
      Hive.registerAdapter(ListWordNotificationAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveVocabRemote)) {
      Hive.registerAdapter(VocabularyRemoteAdapter());
    }
    final box = await Hive.openBox<ListWordNotification>(
        KeyBoxHiveLocal.listWordNotificationKeyBox);
    ListWordNotification listWordNotification =
        box.get(KeyBoxHiveLocal.listWordNotificationKeyBox) ??
            ListWordNotification.empty();
    listWordNotification.listWordNotification.remove(wordNotification);
    await box.put(
        KeyBoxHiveLocal.listWordNotificationKeyBox, listWordNotification);
  }

  Future<void> updateWordNotificationByWordNotification(
      WordNotification wordNotification) async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveEnumWordNoti)) {
      Hive.registerAdapter(ThresholdWordsAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveWordNoti)) {
      Hive.registerAdapter(WordNotificationAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListwordNotificationId)) {
      Hive.registerAdapter(ListWordNotificationAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveVocabRemote)) {
      Hive.registerAdapter(VocabularyRemoteAdapter());
    }
    final box = await Hive.openBox<ListWordNotification>(
        KeyBoxHiveLocal.listWordNotificationKeyBox);
    ListWordNotification listWordNotification =
        box.get(KeyBoxHiveLocal.listWordNotificationKeyBox) ??
            ListWordNotification.empty();
    listWordNotification.listWordNotification.removeWhere((element) =>
        element.englishWords.word == wordNotification.englishWords.word);
    listWordNotification.listWordNotification.add(wordNotification);
    await box.put(
        KeyBoxHiveLocal.listWordNotificationKeyBox, listWordNotification);
  }

  Future<void> updatePriorityWordNotification(WordNotification word) async {
    ListWordNotification listWordNotification = await getListWordNotification();

    List<WordNotification> currentListNotification =
        listWordNotification.listWordNotification;

    for (var item in currentListNotification) {
      if (item.englishWords.word == word.englishWords.word) {
        WordNotification newWord = item.copyWith(
          failureCount: word.failureCount - 1,
        );

        List<WordNotification> newList = currentListNotification
            .map((e) =>
                e.englishWords.word == word.englishWords.word ? newWord : e)
            .toList();

        await updateListWordNotification(
            ListWordNotification(listWordNotification: newList));
        return;
      }
    }
  }

  Future<WordNotification> getWordNotificationsLocal() async {
    ListWordNotification listWordNotification = await getListWordNotification();

    List<WordNotification> wordNotification =
        listWordNotification.listWordNotification;

    int highestPriority = -1000;
    int index = 0;

    if (wordNotification.isNotEmpty) {
      for (int i = 0; i < wordNotification.length; i++) {
        if ((wordNotification[i].failureCount -
                wordNotification[i].successCount) >
            highestPriority) {
          highestPriority = (wordNotification[i].failureCount -
              wordNotification[i].successCount);
          index = i;
        }
      }

      await updatePriorityWordNotification(wordNotification[index]);

      return wordNotification[index];
    }

    return WordNotification.empty();
  }

  Future<ListWordNotification> getNWordNotificationLocal(int n) async {
    List<WordNotification> listWordNotification = [];
    for (int i = 0; i < n; i++) {
      WordNotification wordResult = await getWordNotificationsLocal();
      listWordNotification.add(wordResult);
    }
    return ListWordNotification(listWordNotification: listWordNotification);
  }
}

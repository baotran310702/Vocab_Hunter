import 'package:english_learner/models/word_notification.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class WordNotificationServices {
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);
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
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListwordNotificationId)) {
      Hive.registerAdapter(ListWordNotificationAdapter());
    }
    final box = await Hive.openBox<ListWordNotification>(
        KeyBoxHiveLocal.listWordNotificationKeyBox);
    return box.get(KeyBoxHiveLocal.listWordNotificationKeyBox) ??
        ListWordNotification.empty();
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
    final box = await Hive.openBox<ListWordNotification>(
        KeyBoxHiveLocal.listWordNotificationKeyBox);
    ListWordNotification listWordNotification =
        box.get(KeyBoxHiveLocal.listWordNotificationKeyBox) ??
            ListWordNotification.empty();
    listWordNotification.listWordNotification.remove(wordNotification);
    await box.put(
        KeyBoxHiveLocal.listWordNotificationKeyBox, listWordNotification);
  }
}

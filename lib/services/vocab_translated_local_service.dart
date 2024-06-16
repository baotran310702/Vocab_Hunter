import 'package:english_learner/models/vocabulary/vocab_translated_local.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// This class was created for the purpose of managing the word notification data locally.
class VocabTranslatedLocalServices {
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);
  }

  /// Save the word notification data to the local database.
  Future<void> saveVocabTranslated(
      ListVocabTranslated listVocabTranslated) async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveVocabularyTranslated)) {
      Hive.registerAdapter(VocabTranslatedLocalModelAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListVocabTranslated)) {
      Hive.registerAdapter(ListVocabTranslatedAdapter());
    }
    final box = await Hive.openBox<ListVocabTranslated>(
        KeyBoxHiveLocal.listVocabTranslatedLocal);
    await box.put(
        KeyBoxHiveLocal.listVocabTranslatedLocal, listVocabTranslated);
  }

  ///Insert a word notification data into the local database.
  ///If the word notification data already exists, it will be updated.
  Future<void> insertVocabTranslated(
      VocabTranslatedLocalModel vocabTranslatedLocal) async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveVocabularyTranslated)) {
      Hive.registerAdapter(VocabTranslatedLocalModelAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListVocabTranslated)) {
      Hive.registerAdapter(ListVocabTranslatedAdapter());
    }

    final box = await Hive.openBox<ListVocabTranslated>(
        KeyBoxHiveLocal.listVocabTranslatedLocal);
    ListVocabTranslated listVocabTranslated = box.get(
            KeyBoxHiveLocal.listVocabTranslatedLocal,
            defaultValue: ListVocabTranslated.empty()) ??
        ListVocabTranslated.empty();

    List<VocabTranslatedLocalModel> newListVocab =
        listVocabTranslated.listVocabTranslated;
    for (var item in newListVocab) {
      if (item.englishWords.word == vocabTranslatedLocal.englishWords.word) {
        return;
      }
    }
    await saveVocabTranslated(ListVocabTranslated(
        listVocabTranslated: newListVocab..add(vocabTranslatedLocal)));
  }

  /// Get the word notification data from the local database.
  Future<ListVocabTranslated> getListVocabTranslated() async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveVocabularyTranslated)) {
      Hive.registerAdapter(VocabTranslatedLocalModelAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListVocabTranslated)) {
      Hive.registerAdapter(ListVocabTranslatedAdapter());
    }
    final box = await Hive.openBox<ListVocabTranslated>(
        KeyBoxHiveLocal.listVocabTranslatedLocal);
    ListVocabTranslated listVocabTranslated = box.get(
            KeyBoxHiveLocal.listVocabTranslatedLocal,
            defaultValue: ListVocabTranslated.empty()) ??
        ListVocabTranslated.empty();
    return listVocabTranslated;
  }

  ///Clear all word notification data in the local database.
  Future<void> clearAllVocabTranslated() async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveVocabularyTranslated)) {
      Hive.registerAdapter(VocabTranslatedLocalModelAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListVocabTranslated)) {
      Hive.registerAdapter(ListVocabTranslatedAdapter());
    }
    final box = await Hive.openBox<ListVocabTranslated>(
        KeyBoxHiveLocal.listVocabTranslatedLocal);
    await box.clear();
  }
}

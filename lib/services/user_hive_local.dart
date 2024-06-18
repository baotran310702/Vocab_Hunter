import 'package:english_learner/models/achievement.dart';
import 'package:english_learner/models/time_notification.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:english_learner/utils/enum.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/vocabulary/vocabulary_remote.dart';

class UserHiveLocal {
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);

    if (Hive.isAdapterRegistered(KeyHiveLocal.hiveTimeNotificationId)) {
      Hive.registerAdapter(TimeNotificationAdapter());
    }
  }

  /// Save user's information to local storage.
  Future<void> saveUser(UserModel user) async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveVocabRemote)) {
      Hive.registerAdapter(VocabularyRemoteAdapter());
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
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveSexLocal)) {
      Hive.registerAdapter(SexAdapter());
    }

    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveEnumAchievementType)) {
      Hive.registerAdapter(CustomAchievementAdapter());
    }

    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveEnumAchievementTypeId)) {
      Hive.registerAdapter(AchievementTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveAchievementId)) {
      Hive.registerAdapter(AchievementAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveUserId)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveUserVocab)) {
      Hive.registerAdapter(UserVocabAdapter());
    }
    final box = await Hive.openBox<UserModel>(KeyBoxHiveLocal.userKeyBox);
    await box.put(KeyBoxHiveLocal.userKeyBox, user);
  }

  /// Get user's information to local storage.
  Future<UserModel> getUser() async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveVocabRemote)) {
      Hive.registerAdapter(VocabularyRemoteAdapter());
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

    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveSexLocal)) {
      Hive.registerAdapter(SexAdapter());
    }

    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveEnumAchievementType)) {
      Hive.registerAdapter(CustomAchievementAdapter());
    }

    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveEnumAchievementTypeId)) {
      Hive.registerAdapter(AchievementTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveAchievementId)) {
      Hive.registerAdapter(AchievementAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveUserId)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveUserVocab)) {
      Hive.registerAdapter(UserVocabAdapter());
    }
    final box = await Hive.openBox<UserModel>(KeyBoxHiveLocal.userKeyBox);
    UserModel usermodel =
        box.get(KeyBoxHiveLocal.userKeyBox) ?? UserModel.initWithId('', '');
    return usermodel;
  }

  /// Remove user's information from local storage.
  Future<void> removeUser() async {
    final box = await Hive.openBox<UserModel>(KeyBoxHiveLocal.userKeyBox);
    await box.delete(KeyBoxHiveLocal.userKeyBox);
  }
}
